Docker image for RHQ

=========================

Description

RHQ Image built on top of rhq-nodb image linked with postgresql image
See: ahovsepy/rhq-nodb , vnguyen/rhq-psql

Usage

1. Build RHQ Image -- build.sh -- builds image from Dockerfile
2. Run image -- run.sh -- runs rhq image container linked with rhq-psql container
3. Cleanup -- cleanup.sh -- kills running rhq and rhq-psql image containers
4. Purge -- purge.sh -- removes existing rhq-nodb, rhq-psql and rhq images
