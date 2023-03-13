#!/usr/bin/python

import logging
import boto3
import os
import json

ec2 = boto3.client('ec2')


logger = logging.getLogger()
logger.setLevel(logging.INFO)


def modify_vpn_tunnel(vpn_connection_id: str, vpn_tunnel_outside_ip_address: str, dpd_timeout: int) -> None:
    logger.info("modify vpn tunnel")

    ec2.modify_vpn_tunnel_options(
        VpnConnectionId=vpn_connection_id,
        VpnTunnelOutsideIpAddress=vpn_tunnel_outside_ip_address,
        TunnelOptions={
            'DPDTimeoutSeconds': dpd_timeout,
        }
    )
    logger.info("modify vpn tunnel complete")


def lambda_handler(event, context):
    # env variables requirements
    vpn_connection_id = os.environ['VPN_CONNECTION_ID']
    dpd_timeout = 30
    enable_restart = os.environ['ENABLED_RESTART']

    message = event['Records'][0]['Sns']['Message']
    parsed_message = json.loads(message)
    vpn_tunnel_outside_ip_address = parsed_message['Trigger']['Dimensions'][0]['value']

    if enable_restart == "true":
        modify_vpn_tunnel(vpn_connection_id, vpn_tunnel_outside_ip_address, dpd_timeout)
    else:
        logger.info("restart currently disabled")
