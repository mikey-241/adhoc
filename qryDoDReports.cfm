<!--- Get DoD Report List. Field_ID = 2000 for main report list --->
<cfquery name="field_options" datasource="#request.dsnCMDB#">
  select * from scm_field_values where
  field_id = 2000
  AND active = 1
  order by Field_Option
</cfquery>
