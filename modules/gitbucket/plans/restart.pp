# @summary Ensures the GitBucket java applet is running
#
# @param targets
#   Target name; can be a single target or a group of targets
#
plan gitbucket::restart (
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
    'check if GitBucket is already running',
    '_catch_errors' => true,
  )

  if count($gitbucket_check.error_set.targets) > 0 {
    out::message("No GitBucket found on targets: ${join($gitbucket_check.error_set.targets, ', ')}. Please run gitbucket::install first.")
  }

  run_task(
    'gitbucket::stop',
    $running_check.ok_set.targets,
    'stop GitBucket',
    'gitbucket_path' => $gitbucket_path,
  )
  run_task(
    'gitbucket::start',
    $gitbucket_check.ok_set.targets,
    'start GitBucket',
    'gitbucket_path' => $gitbucket_path,
  )
}
