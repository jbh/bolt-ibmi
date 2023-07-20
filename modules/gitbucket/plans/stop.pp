# @summary Ensures the GitBucket java applet is stopped
#
# @param targets
#   Target name; can be a single target or a group of targets
#
plan gitbucket::stop (
  TargetSpec $targets,
) {
  $gitbucket_path = '/opt/gitbucket'
  $gitbucket_check = run_command(
    "test -f ${$gitbucket_path}/gitbucket.war",
    $targets,
    'check if GitBucket exists',
    '_catch_errors' => true,
  )
  $running_check = run_command(
    "test -f ${$gitbucket_path}/gitbucket.pid",
    $gitbucket_check.ok_set.targets,
    'check if GitBucket is already stopped',
    '_catch_errors' => true,
  )

  if count($gitbucket_check.error_set.targets) > 0 {
    out::message("No GitBucket found on targets: ${join($gitbucket_check.error_set.targets, ', ')}. Please run gitbucket::install first.")
  }

  if count($running_check.error_set.targets) > 0 {
    out::message("GitBucket is already stopped on targets: ${join($running_check.error_set.targets)}.")
  }

  run_task(
    'gitbucket::stop',
    $running_check.ok_set.targets,
    'stop GitBucket',
    'gitbucket_path' => $gitbucket_path,
  )
}
