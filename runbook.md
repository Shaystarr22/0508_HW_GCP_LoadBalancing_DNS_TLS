# Anti-Drunk Engineer Runbook

## Goal

Troubleshoot a Google Compute Engine VM that is not accessible over HTTP and does not allow SSH access.

## Scope

This runbook applies to troubleshooting public-facing GCP virtual machines that are expected to serve web traffic and allow administrative SSH access.

## Prerequisites

Before beginning troubleshooting, ensure the following are available:

- Access to the correct GCP project
- Compute Engine permissions
- gcloud CLI installed and authenticated
- Ability to view firewall rules, VM details, and serial console logs
- VM name and zone information

---

# Investigation Process

## Step 1 – Verify VM Status

First confirm that the VM exists and is currently running.

Command used:

```bash
gcloud compute instances list
```

Things to verify:
- VM status is RUNNING
- External IP address exists
- Correct zone and network are being used

If the VM is stopped, start the VM before continuing troubleshooting.

---

## Step 2 – Verify External Connectivity

Test whether the VM responds publicly over HTTP.

Command used:

```bash
curl http://EXTERNAL_IP
```

Possible results:
- Successful HTTP response
- Connection timeout
- Connection refused
- Empty response

A timeout or refusal may indicate firewall or web service issues.

---

## Step 3 – Verify Firewall Rules

Inspect firewall rules for HTTP and SSH access.

Command used:

```bash
gcloud compute firewall-rules list
```

Verify:
- TCP port 22 is allowed for SSH
- TCP port 80 is allowed for HTTP
- Correct target tags are applied
- Firewall rules are attached to the correct VPC

If HTTP traffic is blocked, confirm the VM includes the required network tag such as:

```text
http-server
```

---

## Step 4 – Verify VM Network Tags

Inspect VM network tags to ensure firewall rules apply correctly.

Command used:

```bash
gcloud compute instances describe VM_NAME --zone ZONE
```

Verify:
- Correct network tags are attached
- Tags match firewall rule target tags

If tags do not match, firewall rules may not apply to the VM.

---

## Step 5 – Verify SSH Connectivity

Attempt SSH access into the VM.

Command used:

```bash
gcloud compute ssh VM_NAME --zone ZONE
```

Possible causes of SSH failure:
- Firewall rule missing for port 22
- Incorrect IAM permissions
- VM missing external IP
- OS Login configuration problems
- Startup script or boot failure

Document all SSH errors during troubleshooting.

---

## Step 6 – Verify Web Service Status

Once SSH access is available, verify that the web service is running.

Commands used:

```bash
sudo systemctl status httpd
```

```bash
sudo systemctl status nginx
```

```bash
sudo ss -tulpn | grep :80
```

Verify:
- Web server service is active
- Port 80 is listening
- No startup failures occurred

---

## Step 7 – Verify Startup Script Execution

Inspect startup script logs and serial console output for failures.

Possible issues:
- Package installation failures
- Invalid startup script commands
- Missing dependencies
- Service startup errors

Serial console logs can provide troubleshooting information when SSH is unavailable.

---

## Step 8 – Root Cause Analysis

After identifying the issue, document:

- Initial symptoms
- Investigation steps taken
- Root cause
- Resolution applied
- Preventative recommendations

---

# Common Failure Scenarios

## Missing Firewall Rule

Symptoms:
- HTTP and/or SSH inaccessible
- VM appears healthy internally

Resolution:
- Create or update ingress firewall rules for required ports

---

## Missing Network Tag

Symptoms:
- Firewall rules exist but traffic still blocked

Resolution:
- Attach correct network tags to the VM

---

## Web Server Failure

Symptoms:
- SSH works
- HTTP fails

Resolution:
- Restart or reinstall web server service
- Verify startup scripts completed successfully

---

## Missing External IP

Symptoms:
- Public connectivity unavailable

Resolution:
- Assign external IP address or configure alternative access method

---

# Validation

After remediation:

Verify SSH:

```bash
gcloud compute ssh VM_NAME --zone ZONE
```

Verify HTTP:

```bash
curl http://EXTERNAL_IP
```

Verify web browser access:
- Open external IP in browser
- Confirm expected webpage loads successfully

---

# Documentation Notes

This runbook was created to improve troubleshooting consistency and reduce recovery time when cloud infrastructure changes accidentally impact production or lab environments.