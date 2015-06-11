# Models

## Revision

### Fields

- `revision_name`: sha1 in git
- `tar_path`: path to tarball (s3://... will be supported)

## Execution

### Fields

- `revision`
- `is_dry_run`
- `status`
- `updated`

## HostExecution

### Fields

- `execution`
- `host`
- `content`

# Endpoints

## GET /revisions

## POST /executions/1/host_executions

- Create a new host_execution

## PUT /host_executions/1/append

- Append host_execution

## POST /hooks/github

- Create tarball from git repository.
- Create a new revision
