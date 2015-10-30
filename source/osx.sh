# Prevent OS X's tar to add ._* hidden files when creating archives
# http://superuser.com/a/61188
export COPYFILE_DISABLE=1

# Create a ram disk mount to specific folder on OS X
# http://superuser.com/questions/456803/create-ram-disk-mount-to-specific-folder-in-osx
#
# Usage:
#
#   mkramdisk /tmp/rdisk            # creates a 2048 MB ram disk
#   -- OR --
#   mkramdisk /tmp/rdisk 4096       # creates a 4 GB ram disk
#
mkramdisk() {
    local mount_point=$1
    local ramfs_size_mb=$2

    if [ -z "$mount_point" ]; then
        echo "error: specify a mount point (e.g. /tmp/rdisk)" >&2
        return
    fi

    if [ -z "$ramfs_size_mb" ]; then
        ramfs_size_mb=2048
    fi

    ramfs_size_sectors=$((${ramfs_size_mb}*1024*1024/512))
    ramdisk_dev=`hdid -nomount ram://${ramfs_size_sectors}`

    newfs_hfs -v 'ram disk' ${ramdisk_dev}
    mkdir -p ${mount_point}
    mount -o noatime -t hfs ${ramdisk_dev} ${mount_point}

    echo "remove with:"
    echo "umount ${mount_point}"
    echo "diskutil eject ${ramdisk_dev}"
}
