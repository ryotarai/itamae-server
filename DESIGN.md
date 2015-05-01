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

## Log

### Fields

- `execution`
- `host`
- `content`

# Endpoints

## GET /revisions

## POST /executions/1/logs

- Create a new log

## PUT /logs/1/append

- Append log

## POST /hooks/github

- Create tarball from git repository.
- Create a new revision
