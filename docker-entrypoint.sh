#!/bin/bash
set -e

# Fly.io 볼륨이 마운트되는 경로
DATA_DIR="/mnt/wiki-data"

# 볼륨 내 디렉토리 목록
DIRS=("content" "cache" "users" "history")

echo "[entrypoint] Initializing persistent storage..."

for DIR in "${DIRS[@]}"; do
    TARGET="$DATA_DIR/$DIR"
    LINK="/var/www/html/$DIR"

    # 볼륨에 디렉토리가 없으면 초기 데이터로 채우기
    if [ ! -d "$TARGET" ]; then
        echo "[entrypoint] First run: copying initial $DIR to volume..."
        cp -r "/init-data-$DIR" "$TARGET"
        chown -R www-data:www-data "$TARGET"
    fi

    # 기존 디렉토리 제거 후 심볼릭 링크 생성
    rm -rf "$LINK"
    ln -s "$TARGET" "$LINK"
    echo "[entrypoint] Linked $LINK -> $TARGET"
done

echo "[entrypoint] Done. Starting Apache..."

exec "$@"