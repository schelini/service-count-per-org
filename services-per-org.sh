#!/bin/bash

ORGS=$(cf curl "/v3/organizations?per_page=5000" | jq -r '.resources[].guid')

for org in $ORGS; do
  ORG_NAME=$(cf curl "/v3/organizations/$org" | jq .name);
  ORG_QUOTA=$(cf curl "/v3/organizations/$org" | jq -r .relationships.quota.data.guid);
  MAX_INSTANCES=$(cf curl "/v3/organization_quotas/$ORG_QUOTA" | jq .services.total_service_instances)
  TOTAL_INSTANCES=$(cf curl "/v3/service_instances?organization_guids=$org" | jq .pagination.total_results)
  echo ORG: $ORG_NAME;
  echo TOTAL INSTANCES: $TOTAL_INSTANCES;
  echo MAX INSTANCES: $MAX_INSTANCES;
  echo '';
done
