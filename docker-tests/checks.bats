#! /usr/bin/env bats

# Variable SUT_IP should be set outside this script and should contain the IP
# address of the System Under Test.

# Tests

@test 'oio-exporter is up and running on port 6920' {
  run bash -c "curl -qs http://${SUT_IP}:6920/config"
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" && "${output}" == *"${SUT_IP}"* ]]
}

@test 'oio-exporter returns valid self metrics' {
  run bash -c "curl -qs http://${SUT_IP}:6920/metrics"
  echo "output: "$output
  echo "status: "$status
  check="openio_self_mem_alloc_current\{host=\"${SUT_ID}\"}"
  echo "check= $check"
  [[ "${status}" -eq "0" && "${output}" =~ $check ]]
}
