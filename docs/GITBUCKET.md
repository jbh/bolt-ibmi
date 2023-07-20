# Bolt IBM i - GitBucket
Documentation relevant to the IBM i GitBucket module.

## What is GitBucket?
GitBucket is a Git web platform that runs on Java, is easy to install, and has
GitHub API compatibility. Since it runs on Java, GitBucket can run on IBM i, making
it simple to run a centralized, secure, and internal DevOps pipeline.

## Plans

### gitbucket::install
Checks if GitBucket exists. It will display the targets where GitBucket already
exists, and it creates `/opt/gitbucket` and uses wget to download `gitbucket.war`
on those targets where GitBucket does not exist.

#### Parameters

##### version `optional`

The version of GitBucket to install. It installs the latest by default.

> Default: undef

##### force `optional`

Whether to force the install and overwrite the current `gitbucket.war` or not.

> Default: false

#### Examples

```bash
bolt plan run gitbucket::install -t ibmi
bolt plan run gitbucket::install -t ibmi version=4.37.2
bolt plan run gitbucket::install -t ibmi force=true
bolt plan run gitbucket::install -t ibmi version=4.36.2 force=true
```

### gitbucket::restart
Checks if GitBucket exists. It will display the targets where GitBucket does not
exist, warning the user to run `gitbucket::install`.

For those targets where GitBucket exists, it checks if GitBucket is running.
It will then run the task `gitbucket::stop` on targets where GitBucket is
running followed by the task `gitbucket::start` on all targets where
GitBucket exists.

#### Examples

```bash
bolt plan run gitbucket::restart -t ibmi
```

### gitbucket::start
Checks if GitBucket exists. It will display the targets where GitBucket does not
exist, warning the user to run `gitbucket::install`.

For those targets where GitBucket exists, it checks if GitBucket is running.
It will then display the targets where GitBucket is already running and
run the task `gitbucket::start` on targets where GitBucket is stopped.

#### Examples

```bash
bolt plan run gitbucket::start -t ibmi
```

### gitbucket::stop
Checks if GitBucket exists. It will display the targets where GitBucket does not
exist, warning the user to run `gitbucket::install`.

For those targets where GitBucket exists, it checks if GitBucket is stopped.
It will then display the targets where GitBucket is already stopped and
run the task `gitbucket::stop` on targets where GitBucket is running.

#### Examples

```bash
bolt plan run gitbucket::stop -t ibmi
```

## Tasks

> These tasks are used by the plans with matching names, and while they can be used
individually, it is recommended to use the plans instead.

### gitbucket::install
A bash script that creates the `/opt/gitbucket` directory and uses wget
to download `gitbucket.war` there.

### gitbucket::start
A bash script that uses nohup to start GitBucket with
`java -jar /opt/gitbucket/gitbucket.war` and creates a `gitbucket.pid` file
containing the GitBucket Process ID.

### gitbucket::stop
A bash script that grabs GitBucket's Process ID, uses it to kill the process,
and removes the `gitbucket.pid` file.