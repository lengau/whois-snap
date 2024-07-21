#!/bin/bash
# Tests for the ruff snap.

set -e

cleanup(){
    rm -rf ruff-snap-test-*
}
trap cleanup EXIT

summary_file="${GITHUB_STEP_SUMMARY:-/dev/stderr}"

domains(){
    echo github.com
    echo snapcraft.io
    echo snapcrafters.org
    echo juju.is
    echo lowe.dev
}

test_domain(){
    echo "::group::Domain: ${domain}"
    whois "${domain}"
    echo "${check_result}"
    echo "::endgroup::"
}

echo -n "whois version: " >> $summary_file
whois --version | tee -a $summary_file
echo "::endgroup::"
echo "::group::Help"
whois --help
echo "::endgroup::"

for domain in $(domains); do
    test_domain "${domain}"
done
