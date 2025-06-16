<!--- Kill extra output. --->
<cfsilent> 
	<!--- Param the URL values. --->
	<cfparam name="url.id" default="" /> 
</cfsilent>
<cfparam name="SAVED_SEARCH_ID" default="">
<!--- Check to see if we have our URL data. --->
<cfif Len(url.id)>
	<!--- <cfdump var="#attributes#"> --->
	<!--- we trimmed do from the query string so that we can pas those selected values back to the edit page --->
	<!---cfif url.id EQ 2005 or url.id EQ 2001 or url.id EQ 2004--->
		<cfif NOT isdefined("attributes.mydata")>
			<cfset d = reReplaceNoCase(cgi.query_string, "do=[^&]+&?", "")>
						<cfset d = "id=" & #url.id#>	
                     <cfloop item="fname" collection="#attributes#">
						<cfif find("SELECT-",fname) gt 0 OR find("WHERE-",fname) gt 0 OR find("EVAL-",fname) gt 0 OR find("CHECKALL",fname) gt 0 >
							<cfset d = d & "&" & #fname# & "=" & #attributes[fname]#>	
                        </cfif>
                    </cfloop>
		<cfelse>
			<cfset d = trim(#attributes.mydata#) & "&id=" & #url.id#>	
		</cfif>	
	<!---cfelse>
		<cfset d = reReplaceNoCase(cgi.query_string, "do=[^&]+&?", "")>
	</cfif--->
<!--- Added code for Multiple MOTS ID issue- Navneet Mishra Starts --->
     <cfset d1 = replaceNoCase('#d#', chr(10), " ", "all")>
	 <cfset d = replaceNoCase('#d1#', chr(13), " ", "all")>
    <!--- Added code for Multiple MOTS ID issue- Navneet Mishra Ends --->
	<!--- <cfoutput>#d#</cfoutput> --->
	<!--- load the form requested by user --->			
			<cfoutput>
				<script type="text/javascript">
				<!--- alert('<cfoutput>#d#</cfoutput>'); --->
					$(document).ready(function(){
						$('##SearchText').html('Loading Form...');
						$('##searching').dialog('open');
						var id= <cfoutput>#url.id#</cfoutput>;									
						$.ajax({
						cache: false,
						//dataType: "json",
						type: 'post',
						url: '<cfoutput>#myself##xfa.loadForm#<cfif SAVED_SEARCH_ID neq "">&SAVED_SEARCH_ID=#SAVED_SEARCH_ID#</cfif></cfoutput>',
						data:'&<cfoutput>#d#</cfoutput>',
						success: function(msg) {$('##searchForm').html(msg);$('##searching').dialog('close');},
						error: function(msg){alert('There was an error');$("##searching").dialog('close');}
					   });
					});				
			   </script>
			</cfoutput>			
 </cfif>

<cfquery name="getForm"  datasource="#request.dsnCMDB#">
   select * from SCM_FORM where form_id = 2000
</cfquery>
<cfif SAVED_SEARCH_ID eq "">
	<cfset request.title = "#getForm.Form_Name#">
<cfelse>
	<cfquery name="getTitle" datasource="DOD_Search">
        SELECT *
        FROM DOD_SAVED_SEARCH
        WHERE SAVED_SEARCH_ID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#SAVED_SEARCH_ID#">
    </cfquery>
    
	<cfset request.title = "Edit #getTitle.SAVED_SEARCH_NAME#">
</cfif>
<cfoutput>
<div class="page_title blue_title" id="pageTitle">#request.title#</div>
<!--- // Ticket No 1424208// --->
<cfif SAVED_SEARCH_ID neq "">
<br/>
<cfif getTitle.SAVED_SEARCH_FILTER neq "">
<center><span id="searchfiltered" style="color:red;font-size:13px;">This save search report has filtered on "#getTitle.SAVED_SEARCH_FILTER#" keyword.</span></center>
</cfif>
</cfif>
<br />
<br />
<div id="searching">
    <img src="assets/images/working.gif" />&nbsp;<span style="font-weight: bold; font-size:24px;" id="SearchText">Processing ... </span>
</div>
<div id="maint">
    <img src="assets/images/working.gif" />&nbsp;<span style="font-weight: bold; font-size:24px;" id="SearchText">Performing Maintenance... </span>
</div>

<a href="<cfoutput>#cgi.SCRIPT_NAME#?do=ah.dspDoDReporting</cfoutput>">DoD Reporting</a> >><br /><br />
#udfAnnouncements('DODREPORTING')#
    <strong>Please choose which report you would like to run.</strong>

<!--- Check for incoming Form ID --->
<form id ="frm1" name="cmdbFormList" action="#myself##xfa.submit#" method="post">
      <table border=0>
        <!--- Get Fields to display on this form --->
        <cfquery name="field_citype" datasource="#request.dsnCMDB#">
        	select * from scm_field_attributes where form_id = 2000
        </cfquery>

        	<!--- Display select fields as select and pull option list from scm_field_values--->
          <tr><td style="font-weight:bold;">#field_citype.field_name#:&nbsp;</td><td>
            <select name="A#field_citype.atrium_id#" id="A#field_citype.atrium_id#" onChange="$('##SearchText').html('Processing...');$('##searching').dialog('open');loadSearchForm($(this).val());" style="width:#field_citype.field_length#px;">
            <option value="0"></option>
        	<cfloop query="field_options">
            		<option value="#field_options.Field_Value#" <cfif #field_options.Field_Value# EQ #URL.id#>selected</cfif>>#field_options.Field_Option#</option>
            </cfloop>
            </select>
          </td></tr>
          <input type="hidden" name="SAVED_SEARCH_ID" value="#SAVED_SEARCH_ID#">
         <cfif SAVED_SEARCH_ID neq "">
          	<input type="hidden" name="Old_SAVED_Report_ID" id="Old_SAVED_Report_ID" value="#getTitle.SAVED_Report_ID#">
          <cfelse>
          	<input type="hidden" name="Old_SAVED_Report_ID" id="Old_SAVED_Report_ID" value="">
          </cfif>
  	</table><br />
</form>
</cfoutput>

<div id="searchForm"></div>
<script type="text/javascript">
		function loadSearchForm(id) {
			
			searchNameV = $('#Old_SAVED_Report_ID').val();
			//alert(searchNameV);
			if (id != searchNameV)
			{
					$('#Old_SAVED_Report_ID').val('');
					$('#searchfiltered').css('display','none'); /*.css(display,'none');*/
					
			}
			/* Against request 1169384 - building new code for Staged Reports (id = 2010) */
			if (id == 2010)
			{
				window.location.href = "<cfoutput>#myself##xfa.loadStagedRpts#</cfoutput>";
			}
			else if(id == 2012)
			{
				window.location.href = "<cfoutput>#myself##xfa.submitMyDod#</cfoutput>";
			}
			else
			{
				//Ajax call to populate Members
			$.ajax({
				cache: false,
				//dataType: "json",
				type: 'post',
				url: '<cfoutput>#myself##xfa.loadForm#</cfoutput>',
				data: 'id=' + id,
				success: function(msg) {$('#searchForm').html(msg);$("#searching").dialog('close');},
				error: function(msg){alert('There was an error');$("#searching").dialog('close');}
			});
		}
	}
		<cfif not structKeyExists(application,'dodformvalues')>
			$(document).ready(function() {
				$("#maint").dialog('open');
			$.ajax({
				cache: false,
				//dataType: "json",
				type: 'post',
				url: '<cfoutput>#myself##xfa.loaddodformvalues#</cfoutput>',
				success: function(msg) {$("#maint").dialog('close');},
				error: function(msg){alert('There was an error.');$("#maint").dialog('close');}
			});
			});
		</cfif>
</script>