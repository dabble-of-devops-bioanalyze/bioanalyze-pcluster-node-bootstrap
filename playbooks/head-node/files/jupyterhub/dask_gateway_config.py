from aws_pcluster_dask_gateway.aws_pcluster_dask_gateway import PClusterBackend
from aws_pcluster_slurm_spawner.aws_pcluster_slurm_spawner import get_ec2_address

from dask_gateway_server.options import Options, String
import shutil
import os

#################################################################
# CONSTANTS
#################################################################

JHUB_VERSION = "2023.09.17"
JUPYTERHUB_BIND_PORT = 8000
JUPYTERHUB_API_PORT = 8081
JUPYTERHUB_CONNECT_IP = get_ec2_address()
DASK_PROXY_ADDRESS = ':8006'
API_TOKEN = "af744654eb3245cb039a5791a997352b606db9528ac5c2ed6fd6c3623193c0b0"

#################################################################
# Authentication
#################################################################

c.DaskGateway.authenticator_class = "dask_gateway_server.auth.JupyterHubAuthenticator"
c.JupyterHubAuthenticator.jupyterhub_api_token = API_TOKEN
c.JupyterHubAuthenticator.jupyterhub_api_url = f'http://{JUPYTERHUB_CONNECT_IP}:{JUPYTERHUB_API_PORT}/hub/api'

#################################################################
# Networking
#################################################################

c.Proxy.address = DASK_PROXY_ADDRESS
c.Proxy.tcp_address = DASK_PROXY_ADDRESS

c.DaskGateway.backend_class = (
    "aws_pcluster_dask_gateway.aws_pcluster_dask_gateway.PClusterBackend"
)
