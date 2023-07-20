# @summary Ensures the GitBucket war file is available and executable.
#
# @param targets
#   Target name; can be a single target or a group of targets
#
# @param version
#   The version of GitBucket to install
#
# @param force
#   Force overwrite of existing GitBucket runtime
#
plan gitbucket::install (
  TargetSpec $targets,
  Optional[String] $version = undef,
  Optional[Boolean] $force  = false,
) {
  $gitbucket_path = '/opt/gitbucket'
  $gitbucket_url = $version ? {
    undef   => 'https://github.com/gitbucket/gitbucket/releases/latest/download/gitbucket.war',
    default => "https://github.com/gitbucket/gitbucket/releases/download/${$version}/gitbucket.war",
  }
  $gitbucket_check = run_command(
    "test -f ${$gitbucket_path}/gitbucket.war",
    $targets,
    'check if GitBucket exists',
    '_catch_errors' => true,
  )

  if count($gitbucket_check.ok_set.targets) > 0 and !$force {
    out::message("The following already have GitBucket: ${join($gitbucket_check.ok_set.targets, ', ')}; use Force to overwrite.")
  }

  $install_targets = $force ? {
    false   => $gitbucket_check.error_set.targets,
    default => $targets,
  }

  run_task(
    'gitbucket::install',
    $install_targets,
    'install GitBucket',
    'gitbucket_path' => $gitbucket_path,
    'gitbucket_url'  => $gitbucket_url,
  )
}
