#!/bin/bash -e

usage() {
    echo $0 clang\|gcc host git-url contender-br baseline-br suite-filter [bechmark-filter]
    echo Examples:
    echo $0 clang wls-arm-amp02 https://github.com/cyb70289/arrow rados master arrow-utf8-util-benchmark
    echo $0 clang wls-arm-m1 https://github.com/apache/arrow 6cdb80c6c 6d3fb1a4b arrow-csv-parser-benchmark \"^ParseCSV\"
    exit 1
}

if [ $# -lt 6 ]; then
    usage
fi

cc=$1
if [ "${cc}" == clang ]; then
    cxx=clang++
elif [ "${cc}" == gcc ]; then
    cxx=g++
else
    usage
fi

host=$2
url=$3
contender=$4
baseline=$5
suite_filter=$6
benchmark_filter=${7:-".*"}

if [[ $host =~ wls-arm-m1.* ]]; then
    ssh cyb@${host} \
        "bash -e -c \
             'export PATH=/opt/homebrew/bin:/Users/cyb/miniforge3/bin:\$PATH; \
              source /Users/cyb/miniforge3/etc/profile.d/conda.sh; \
              conda activate venv; \
              rm -rf /tmp/__arrow-bench; \
              git clone ${url} /tmp/__arrow-bench; cd /tmp/__arrow-bench; \
              git branch ${contender} origin/${contender} 2>/dev/null || :; \
              git branch ${baseline} origin/${baseline} 2>/dev/null || :; \
              CONDA_PREFIX= archery benchmark diff ${contender} ${baseline} \
                   --suite-filter=${suite_filter} \
                   --benchmark-filter=${benchmark_filter} \
                   --cc=${cc} --cxx=${cxx}'"
else
    ssh cyb@${host} \
        "sudo docker run -t --rm cyb-dev-arrow \
         bash -e -c \
             'source /home/cyb/venv/bin/activate;
              git clone ${url} arrow-bench; cd arrow-bench; \
              git branch ${contender} origin/${contender} 2>/dev/null || :; \
              git branch ${baseline} origin/${baseline} 2>/dev/null || :; \
              pip install -e dev/archery; \
              archery benchmark diff ${contender} ${baseline} \
                   --suite-filter=${suite_filter} \
                   --benchmark-filter=${benchmark_filter} \
                   --cc=${cc} --cxx=${cxx}'"
fi
