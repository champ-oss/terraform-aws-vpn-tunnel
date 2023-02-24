#!/usr/bin/python

import logging
import boto3
import os
from random import *
import json

ec2 = boto3.client('ec2')


logger = logging.getLogger()
logger.setLevel(logging.INFO)


def modify_vpn_tunnel(vpn_connection_id: str, vpn_tunnel_outside_ip_address: str) -> None:
    logger.info("modify vpn tunnel")
    random_dpd_timeout = randint(30, 130)  # Pick a random number between 30 and 130.

    ec2.modify_vpn_tunnel_options(
        VpnConnectionId=vpn_connection_id,
        VpnTunnelOutsideIpAddress=vpn_tunnel_outside_ip_address,
        TunnelOptions={
            'DPDTimeoutSeconds': random_dpd_timeout,
        }
    )
    logger.info("modify vpn tunnel complete")


def lambda_handler(event, context):
    # env variables requirements
    vpn_connection_id = os.environ['VPN_CONNECTION_ID']

    message = event['Records'][0]['Sns']['Message']
    parsed_message = json.loads(message)
    vpn_tunnel_outside_ip_address = parsed_message['Trigger']['Dimensions'][0]['value']

    modify_vpn_tunnel(vpn_connection_id, vpn_tunnel_outside_ip_address)
