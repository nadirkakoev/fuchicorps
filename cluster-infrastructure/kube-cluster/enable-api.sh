#!/bin/bash
echo 'Enabling google api'
gcloud services enable compute.googleapis.com
gcloud services enable dns.googleapis.com
gcloud services enable storage-api.googleapis.com
gcloud services enable container.googleapis.com

