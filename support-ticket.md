# Support Ticket – Broken GCP VM Environment

## Summary

A Google Compute Engine VM intended to function as a public web server was not accessible over HTTP and initially did not allow SSH access.

## Expected Behavior

The VM should:
- Allow SSH access over port 22
- Serve HTTP traffic publicly over port 80
- Respond successfully to curl and browser requests

## Observed Behavior

Observed issues included:
- HTTP requests failing
- SSH access initially unavailable
- Connectivity problems during testing

## Initial Investigation

Initial troubleshooting steps included:
- Verifying VM status
- Checking external IP assignment
- Inspecting firewall rules
- Verifying VM network tags
- Testing HTTP connectivity with curl
- Attempting SSH access with gcloud CLI

Commands used:

```bash
gcloud compute instances list
```

```bash
gcloud compute firewall-rules list
```

```bash
curl http://EXTERNAL_IP
```

```bash
gcloud compute ssh VM_NAME --zone ZONE
```

## Root Cause

At the time of investigation, the provided environment setup script returned a `404 Not Found` error because the Google Cloud Storage object did not exist.

This prevented successful deployment and testing of the intended broken environment.

## Resolution

The issue was escalated to the instructor/group leader to request an updated setup script URL.

## Preventative Recommendations

- Validate assignment setup scripts before distribution
- Maintain version-controlled lab scripts
- Verify GCS object permissions and availability before assignment release
- Reference the Anti-Drunk Engineer Runbook for future troubleshooting workflows

## Related Documentation

See:
- `README.md`
- `runbook.md`