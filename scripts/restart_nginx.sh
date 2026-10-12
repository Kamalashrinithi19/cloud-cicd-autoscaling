
#!/bin/bash
set -e

nginx -t
systemctl enable nginx
systemctl restart nginx

for attempt in $(seq 1 10); do
    if curl -fsS http://127.0.0.1/health >/dev/null; then
        echo "Nginx and health endpoint are ready."
        exit 0
    fi
    sleep 2
done

echo "Health endpoint failed."
exit 1
