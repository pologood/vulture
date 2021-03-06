#!/bin/bash

if [ $# -lt 4 ]; then
  echo "usage: $0 <inputPath> <filePattern> <HOT|WARM|COLD> <filePrefix>"
  exit 1
fi

dir=`dirname $0`
dir=`cd $dir; pwd`

inputPath=$1
filePattern=$2
compressType=$3
filePrefix=$4
outputPath=$inputPath
tmpPath='/logdata/tmp/hdfs_compress_tmp'
trashPath='/logdata/tmp/hdfs_compress_trash'
ymd=`date +%Y%m%d`

if [[ $inputPath == /logdata* ]]; then
  tmpPath='/logdata/tmp/hdfs_compress_tmp'
  trashPath='/logdata/tmp/hdfs_compress_trash'
elif [[ $inputPath == /storage* ]]; then
  tmpPath='/storage/tmp/hdfs_compress_tmp'
  trashPath='/storage/tmp/hdfs_compress_trash'
elif [[ $inputPath == /cloud* ]]; then
  tmpPath='/cloud/tmp/hdfs_compress_tmp'
  trashPath='/cloud/tmp/hdfs_compress_trash'
fi

hadoop jar $dir/hadoop-extras-1.0-SNAPSHOT.jar \
  com.sogou.hadoop.extras.tools.hdfs.compress.DistributedHdfsCompression \
  -DfilePrefix=$filePrefix -DoutputPath=$outputPath -DtmpPath=$tmpPath -DtrashPath=$trashPath \
  $inputPath $filePattern $compressType
