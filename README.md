Stroller
--------
The ultimate companion to Vagrant.

## What is it?
Stroller is simply a series of automation tasks to automate the
boostrap/setup/usage/sharing of a complete Infrastructure Development
Environment with Configuration Management[1]. 

## Goals
The goal of this project is simple: provide a common mechanism for
Developers and Administrators to develop applications and
Infrastructure. This includes workflow to integrate one of those awesome
CM tools we talked about earlier (or is down in the references, if you
like to save those for last).

## Getting Started
You need to hook up to your existing CM database. Edit the provisioner
of your choice located in the `config` directory to the path where your
manifests/cookbooks/bundles are, and then go and start developing! You
may alternatively clone this repository and setup your own configuration
for your environment. 

Edit all of the values in `config/autogen_defaults.yml` that are
labeled `FILL_ME_IN`

## Provisioners
### Puppet
This provisioner allows support for running Puppet on a node without a
Puppet Master.

```
manifest_file: the file used to define nodes for your puppet env.
manifests_path: location to where your puppet manifest is stored.
modules: array of values where your puppet modules live.
options: array of any options to be passed to puppet
```

### Puppet Server
This provisioner allows support for running Puppet on a node connected
to a Puppet Master. Should be configured for testing out a Puppet Master

```
server: the Puppet Master server agent should connect to
options: array of options to be passed to puppet agent
```

### Chef-Solo
This provisioner allows support for running Chef-solo on a node.

```
log_level: logging level passed to chef-solo
environment: string to define the chef environment
roles: array of roles applied by chef-solo
```

Read up on the VAGRANT.md file. It'll tell you what you need to know
about using this set of helper scripts.

References
----------
[1] You know, like Puppet, or Chef, or CFengine
