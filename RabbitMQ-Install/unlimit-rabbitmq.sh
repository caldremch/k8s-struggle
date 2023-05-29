# 参考github rabbitmq安装错误issues的修改方式.

if [ -n "${RABBITMQ_ULIMIT_NOFILES:-}" ]; then
    current_limit=$(ulimit -n)
    if [ "$current_limit" != "unlimited" ]; then
        # shellcheck disable=SC2086
        if [ $RABBITMQ_ULIMIT_NOFILES -gt $current_limit ]; then
            info "Setting file description limit to $RABBITMQ_ULIMIT_NOFILES"
            ulimit -n $RABBITMQ_ULIMIT_NOFILES
        fi
    fi
fi