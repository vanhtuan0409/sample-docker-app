# Min.io

Distributed fileserver with S3 interface
https://github.com/minio/minio

### Commands

- Modify `~/.mc/config.json` for host alias and credentials
- Set bucket as public:
  - `mc policy download {host_alias}/{bucket_name}`
- Add user:
  - `mc admin user add {host_alias} {user_name} {user_secret}`
- Add policy:
  - `mc admin policy add {host_alias} {policy_name} {policy_config_file}`
- Binding policy to user:
  - `mc admin policy set {host_alias} {policy} user={user_name}`
