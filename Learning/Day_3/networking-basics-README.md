# 🌐 Networking Basics — Study Notes
> **Goal:** TCP/UDP, DNS, HTTP basics | **Est. Time:** 1.5 hours  
> **Tools:** `curl`, `dig` | **Date:** ___________

---

## Table of Contents
1. [TCP vs UDP](#1-tcp-vs-udp)
2. [Common Ports](#2-common-ports)
3. [DNS — Domain Name System](#3-dns--domain-name-system)
4. [HTTP — HyperText Transfer Protocol](#4-http--hypertext-transfer-protocol)
5. [curl Cheat Sheet](#5-curl-cheat-sheet)
6. [dig Cheat Sheet](#6-dig-cheat-sheet)
7. [My Practice Outputs](#7-my-practice-outputs)

---

## 1. TCP vs UDP

### TCP (Transmission Control Protocol)
- **Type:** Connection-oriented
- **Handshake:** SYN → SYN-ACK → ACK (3-way handshake before data transfer)
- **Guarantees:** Delivery ✅ | Order ✅ | Error checking ✅
- **Speed:** Slower (due to overhead)
- **Use cases:** HTTP/HTTPS, SSH, FTP, Email

### UDP (User Datagram Protocol)
- **Type:** Connectionless
- **Handshake:** None — fires and forgets
- **Guarantees:** Delivery ❌ | Order ❌ | Error checking ⚠️ (basic checksum only)
- **Speed:** Faster (low overhead)
- **Use cases:** DNS, video streaming, VoIP, online gaming

### Key Difference Summary
| Feature | TCP | UDP |
|---|---|---|
| Connection | Required (handshake) | Not required |
| Reliability | Guaranteed | Not guaranteed |
| Speed | Slower | Faster |
| Order | Preserved | Not preserved |
| Overhead | High | Low |

### My Notes:
> _Write your own understanding here after reading..._
>
> TCP is like ___________
> UDP is like ___________

---

## 2. Common Ports

| Service | Port | Protocol | Notes |
|---|---|---|---|
| HTTP | 80 | TCP | Unencrypted web traffic |
| HTTPS | 443 | TCP | Encrypted web traffic (TLS) |
| SSH | 22 | TCP | Secure remote shell |
| FTP | 21 | TCP | File transfer (control) |
| FTP Data | 20 | TCP | File transfer (data) |
| SMTP | 25 | TCP | Sending email |
| SMTP (TLS) | 587 | TCP | Sending email (authenticated) |
| IMAP | 143 | TCP | Reading email |
| IMAPS | 993 | TCP | Reading email (encrypted) |
| POP3 | 110 | TCP | Reading email (older) |
| DNS | 53 | UDP + TCP | Name resolution |
| DHCP | 67/68 | UDP | IP address assignment |
| RDP | 3389 | TCP | Remote Desktop (Windows) |
| MySQL | 3306 | TCP | Database |
| PostgreSQL | 5432 | TCP | Database |
| Redis | 6379 | TCP | In-memory data store |
| MongoDB | 27017 | TCP | NoSQL database |

### My Notes:
> _Any ports you want to highlight or remember..._

---

## 3. DNS — Domain Name System

### What is DNS?
DNS translates human-readable domain names (e.g. `google.com`) into IP addresses (e.g. `142.250.80.46`) that computers use to communicate.

### How DNS Resolution Works (Step by Step)
```
You type: google.com
    ↓
1. Browser checks its own cache
    ↓
2. OS checks /etc/hosts file
    ↓
3. Query sent to Recursive Resolver (e.g. 8.8.8.8 or your ISP)
    ↓
4. Resolver asks Root Nameserver → "Who handles .com?"
    ↓
5. Root says → "Ask the .com TLD Nameserver"
    ↓
6. TLD Nameserver says → "Ask Google's Authoritative Nameserver"
    ↓
7. Authoritative Nameserver returns the IP address
    ↓
8. Resolver caches it (with TTL) and returns IP to you
    ↓
Your browser connects to: 142.250.80.46
```

### DNS Record Types
| Record | Purpose | Example |
|---|---|---|
| `A` | Domain → IPv4 address | `google.com → 142.250.80.46` |
| `AAAA` | Domain → IPv6 address | `google.com → 2607:f8b0:...` |
| `CNAME` | Alias → another domain | `www.example.com → example.com` |
| `MX` | Mail server for domain | `google.com → smtp.google.com` |
| `NS` | Nameserver for domain | `google.com → ns1.google.com` |
| `TXT` | Arbitrary text (SPF, DKIM, verification) | `"v=spf1 include:..."` |
| `PTR` | IP → domain (reverse DNS) | `142.250.80.46 → lax.google.com` |
| `SOA` | Start of authority (zone metadata) | Serial, refresh, retry info |
| `SRV` | Service location | Used by VoIP, Kubernetes, etc. |

### What is TTL?
TTL (Time To Live) is the number of **seconds** a DNS record is cached before it must be re-fetched. A TTL of `300` means cached for 5 minutes.

### My Notes:
> _Your understanding of DNS after practicing..._

---

## 4. HTTP — HyperText Transfer Protocol

### What is HTTP?
HTTP is the application-layer protocol for transmitting web pages and APIs over the internet. It runs over TCP (port 80 for HTTP, port 443 for HTTPS).

### Request / Response Cycle
```
CLIENT                              SERVER
  |                                   |
  |--- TCP Handshake (SYN/SYN-ACK) -->|
  |                                   |
  |--- HTTP Request ------------------>|
  |    GET /index.html HTTP/1.1        |
  |    Host: example.com               |
  |    User-Agent: curl/7.88           |
  |    Accept: */*                     |
  |                                    |
  |<-- HTTP Response -----------------|
  |    HTTP/1.1 200 OK                 |
  |    Content-Type: text/html         |
  |    Content-Length: 1256            |
  |                                    |
  |    <html>...</html>                |
```

### HTTP Methods
| Method | Purpose | Has Body? | Idempotent? |
|---|---|---|---|
| `GET` | Retrieve a resource | No | Yes |
| `POST` | Create / submit data | Yes | No |
| `PUT` | Replace a resource entirely | Yes | Yes |
| `PATCH` | Partially update a resource | Yes | No |
| `DELETE` | Remove a resource | Optional | Yes |
| `HEAD` | Like GET but returns headers only | No | Yes |
| `OPTIONS` | What methods does this endpoint support? | No | Yes |

### HTTP Status Codes
| Code | Name | Meaning |
|---|---|---|
| **2xx — Success** | | |
| 200 | OK | Request succeeded |
| 201 | Created | Resource was created (after POST) |
| 204 | No Content | Success, but no body returned |
| **3xx — Redirection** | | |
| 301 | Moved Permanently | Resource has a new permanent URL |
| 302 | Found | Temporary redirect |
| 304 | Not Modified | Use cached version |
| **4xx — Client Errors** | | |
| 400 | Bad Request | Invalid syntax or missing fields |
| 401 | Unauthorized | Not authenticated |
| 403 | Forbidden | Authenticated but not allowed |
| 404 | Not Found | Resource doesn't exist |
| 405 | Method Not Allowed | That HTTP method isn't supported here |
| 429 | Too Many Requests | Rate limited |
| **5xx — Server Errors** | | |
| 500 | Internal Server Error | Generic server failure |
| 502 | Bad Gateway | Upstream server error |
| 503 | Service Unavailable | Server is down or overloaded |
| 504 | Gateway Timeout | Upstream server timed out |

### Common HTTP Headers
| Header | Direction | Purpose |
|---|---|---|
| `Host` | Request | Target domain |
| `Content-Type` | Both | Format of the body (e.g. `application/json`) |
| `Authorization` | Request | Auth token/credentials |
| `Accept` | Request | What response formats the client wants |
| `User-Agent` | Request | Identifies the client (browser, curl, etc.) |
| `Location` | Response | URL for redirects |
| `Set-Cookie` | Response | Sends a cookie to the client |
| `Cache-Control` | Both | Caching directives |

### My Notes:
> _Your understanding of HTTP after practicing..._

---

## 5. curl Cheat Sheet

### Basic Usage
```bash
# Simple GET request
curl https://example.com

# Fetch headers only (HEAD request)
curl -I https://example.com

# Verbose — shows full request + response including headers
curl -v https://example.com

# Follow redirects (e.g. HTTP → HTTPS)
curl -L https://example.com

# Save response body to a file
curl -o output.html https://example.com

# Print only the HTTP status code
curl -o /dev/null -s -w "%{http_code}\n" https://example.com
```

### Making Requests with Data
```bash
# POST with JSON body
curl -X POST https://httpbin.org/post \
     -H "Content-Type: application/json" \
     -d '{"name": "Alice", "age": 30}'

# POST with form data
curl -X POST https://httpbin.org/post \
     -d "username=alice&password=secret"

# PUT request
curl -X PUT https://httpbin.org/put \
     -H "Content-Type: application/json" \
     -d '{"id": 1, "name": "Updated Name"}'

# DELETE request
curl -X DELETE https://httpbin.org/delete
```

### Useful Flags Summary
| Flag | Meaning |
|---|---|
| `-v` | Verbose (show headers + connection info) |
| `-I` | HEAD request (headers only) |
| `-L` | Follow redirects |
| `-o <file>` | Save output to file |
| `-s` | Silent mode (no progress bar) |
| `-X <METHOD>` | Specify HTTP method |
| `-H "Key: Value"` | Add a request header |
| `-d "data"` | Request body / POST data |
| `-u user:pass` | Basic auth |
| `-w "%{http_code}"` | Print specific info after request |
| `--max-time 10` | Timeout after 10 seconds |

### Practice Sites
- `https://httpbin.org` — returns your request info back as JSON (great for testing)
- `https://example.com` — simple static page
- `https://jsonplaceholder.typicode.com` — fake REST API for practice

---

## 6. dig Cheat Sheet

### Basic Usage
```bash
# Default A record lookup
dig google.com

# Short output — just the IP
dig +short google.com

# Look up a specific record type
dig google.com MX
dig google.com NS
dig google.com TXT
dig google.com AAAA
dig google.com CNAME

# Use a specific DNS resolver (e.g. Google's 8.8.8.8)
dig @8.8.8.8 google.com

# Reverse DNS — IP to hostname
dig -x 8.8.8.8

# Trace full resolution path from root
dig +trace google.com
```

### Understanding dig Output
```
; <<>> DiG 9.18 <<>> google.com
;; ANSWER SECTION:
google.com.     212    IN    A    142.250.80.46
   ^             ^     ^    ^         ^
   Domain      TTL   Class  Type    Value
               (sec)
```

### Useful dig Flags
| Flag | Meaning |
|---|---|
| `+short` | Only show the answer (no metadata) |
| `+trace` | Trace the full DNS resolution path |
| `+noall +answer` | Show only the answer section |
| `@<resolver>` | Use a specific DNS server |
| `-x <ip>` | Reverse DNS lookup |
| `-p <port>` | Query on a non-standard port |

---

## 7. My Practice Outputs

> **Instructions:** Run each command and paste the output below. Add your own notes about what you observe.

---

### DNS Practice

#### `dig google.com`
```
# Paste output here
```
**What I noticed:** ___________

---

#### `dig +short google.com`
```
# Paste output here
```
**What I noticed:** ___________

---

#### `dig google.com MX`
```
# Paste output here
```
**What I noticed:** ___________

---

#### `dig google.com NS`
```
# Paste output here
```
**What I noticed:** ___________

---

#### `dig @8.8.8.8 google.com`
```
# Paste output here
```
**What I noticed:** ___________

---

#### `dig -x 8.8.8.8` (Reverse DNS)
```
# Paste output here
```
**What I noticed:** ___________

---

#### `dig +trace google.com` (Full resolution path)
```
# Paste output here — it'll be long!
```
**What I noticed:** ___________

---

### HTTP Practice

#### `curl -I https://example.com` (Headers only)
```
# Paste output here
```
**What I noticed:** ___________

---

#### `curl -v https://example.com` (Verbose)
```
# Paste output here
```
**What I noticed:** ___________

---

#### `curl https://httpbin.org/get` (See your own request)
```
# Paste output here
```
**What I noticed:** ___________

---

#### `curl -X POST https://httpbin.org/post -H "Content-Type: application/json" -d '{"name":"test"}'`
```
# Paste output here
```
**What I noticed:** ___________

---

#### `curl -o /dev/null -s -w "%{http_code}\n" https://example.com` (Status code only)
```
# Paste output here
```
**What I noticed:** ___________

---

#### `curl -L http://example.com` (Follow redirect HTTP → HTTPS if any)
```
# Paste output here
```
**What I noticed:** ___________

---

## Key Takeaways

> _Fill this in at the end of your session — summarize the 3 most important things you learned._

1. 
2. 
3. 

---

## Questions / Things to Explore Further

> _Note anything that confused you or that you want to dig deeper into._

- 
- 
- 

---

*Last updated: ___________*
