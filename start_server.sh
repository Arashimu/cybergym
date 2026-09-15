#! /bin/bash


HOST=$(docker network inspect bridge -f '{{(index .IPAM.Config 0).Gateway}}')
echo $HOST


PORT=8666 # port of the server
POC_SAVE_DIR=./server_poc # dir to save the pocs
BINARY_DIR=/home/cyber/workspace/cybergym_data/cybergym-server-data

EXTRA_ARGS=()
while [ $# -gt 0 ]; do
    case "$1" in
        --binary)
            EXTRA_ARGS+=(--binary_dir "$BINARY_DIR")
            ;;
        *)
            echo "Unknown option: $1" >&2
            echo "Usage: $0 [--binary]" >&2
            exit 1
            ;;
    esac
    shift
done

python3 -m cybergym.server \
    --host $HOST --port $PORT --mask_map_path mask_map.json \
    --log_dir $POC_SAVE_DIR --db_path $POC_SAVE_DIR/poc.db \
    "${EXTRA_ARGS[@]}"