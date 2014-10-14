# BOSH deployed Jenkins for CloudFoundry CI

[![Build Status](https://travis-ci.org/FreightTrain/C3CI-jenkins.svg?branch=master)](https://travis-ci.org/FreightTrain/C3CI-jenkins)

Based on the [Jenkins release by Dr Nic](https://github.com/cloudfoundry-community/jenkins-boshrelease).

Includes jobs to deploy CloudFoundry in an automated way. 

Additional features include automatic install of plugins from manifest, automatic Jenkins server configuration, automatic Jenkins job configuration with bundled jobs and job accessable environmental variables for ease of use.

## Deploy on bosh-lite

Upload release

```
git clone https://github.com/FreightTrain/C3CI-jenkins
cd C3CI-jenkins
bosh create release
bosh upload release
```

Deploy

```
./templates/make_manifest warden examples/warden-stub.yml
bosh deploy
```

