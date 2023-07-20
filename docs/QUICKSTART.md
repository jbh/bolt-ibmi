# Bolt IBM i - Quickstart
A convenient quickcstart guide for IBM

## Install Prerequisites

### IBM i Open Source Package Manager (OSPM)
The IBM i OSPM gives you access to yum, which is a great package manager for open source
binaries provided by the official IBM i RPM repositories. It can be
[installed](https://www.ibm.com/support/pages/getting-started-open-source-package-management-ibm-i-acs)
a few different ways depending on your server's access to the internet. The most convenient
way is to use Access Client Solutions to install IBM i OSPM.

### Bolt CLI
Be sure to install [Bolt CLI](https://www.puppet.com/docs/bolt/latest/bolt_installing.html)
on your local machine. This will allow you to run the plans in this repository.

## Clone repository

You can directly clone this repository; or feel free to fork, clone, and contribute your own plans.

```bash
git clone https://github.com/jbh/bolt-ibmi.git
```

## Copy inventory and define targets

This repository provides an example inventory file, which is required by Bolt for it to
keep track of target servers and how to connect to them. Simply copy it:

```bash
cd bolt-ibmi
cp inventory-example.yaml inventory.yaml
```

Then replace the placeholders: `IBMI_NAME`, `IBMI_URI`, and `IBMI_USERNAME` with their relevant
values, and add as many groups and targets as you like.

## Run plans

Keep in mind that plans and tasks are run on a target, so they must have a target as an
argument. This is done using the `-t` option with Bolt CLI. A target can be a group name consisting
of many targets or a single target.

### GitBucket example

```bash
cd bolt-ibmi
bolt plan run gitbucket::install -t ibmi
bolt plan run gitbucket::start -t ibmi
bolt plan run gitbucket::restart -t ibmi
bolt plan run gitbucket::stop -t ibmi
```