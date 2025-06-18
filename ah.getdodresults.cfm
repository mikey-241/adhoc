<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: ah --->
<!--- fuseaction: getDoDResults --->
<cftry>
<!--- do action="sec.login" --->
<cfset myFusebox.thisPhase = "preprocessFuseactions">
<cfset myFusebox.thisCircuit = "sec">
<cfset myFusebox.thisFuseaction = "login">
<cftry>
<cfoutput><cfinclude template="../security/actLogin.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 12 and right(cfcatch.MissingFileName,12) is "actLogin.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse actLogin.cfm in circuit sec which does not exist (from fuseaction sec.login).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<!--- do action="o.ann" --->
<cfset myFusebox.thisCircuit = "o">
<cfset myFusebox.thisFuseaction = "ann">
<cftry>
<cfoutput><cfinclude template="../other/actAnnouncements.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 20 and right(cfcatch.MissingFileName,20) is "actAnnouncements.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse actAnnouncements.cfm in circuit o which does not exist (from fuseaction o.ann).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfset myFusebox.thisPhase = "requestedFuseaction">
<cfset myFusebox.thisCircuit = "ah">
<cfset myFusebox.thisFuseaction = "getDoDResults">
<cfset xfa.link1 = "ah.report1" />
<cfset xfa.link2 = "ah.report2" />
<cfset xfa.link3 = "ah.report3" />
<cfset xfa.link4 = "ah.report4" />
<cfset xfa.link5 = "ah.report5" />
<cfset xfa.link6 = "ah.dspMyReports" />
<cfset xfa.link8 = "ah.report3" />
<cfset xfa.linkDoD = "ah.dspDoDReporting" />
<cfset xfa.assetSearch = "ah.assetSearch" />
<cfset xfa.loadDataset = "ah.qryLoadDataset" />
<cfset xfa.loadType = "ah.qryColType" />
<cfset xfa.qryAdminSection = "ah.qryAdminSection" />
<cfset xfa.actSaveAdmin = "ah.actSaveAdmin" />
<cfset xfa.actAddDupCol = "ah.actAddDupCol" />
<cfset xfa.dspLblDescript = "ah.dspLblDescript" />
<cftry>
<cfoutput><cfinclude template="../adhocReports/../udfAnnouncements.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 23 and right(cfcatch.MissingFileName,23) is "../udfAnnouncements.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse ../udfAnnouncements.cfm in circuit ah which does not exist (from fuseaction ah.$prefuseaction).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cftry>
<cfsavecontent variable="request.topnav"><cfoutput><cfinclude template="../adhocReports/dspMain.cfm"></cfoutput></cfsavecontent>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 11 and right(cfcatch.MissingFileName,11) is "dspMain.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse dspMain.cfm in circuit ah which does not exist (from fuseaction ah.$prefuseaction).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfset xfa.goexcel = "ah.getDoDExcelResults" />
<cfset xfa.mailexcel = "ah.DoDExcelResults" />
<cfset xfa.loadResults = "ah.actDoDQuery" />
<cfset xfa.dspDoDRMAN = "ah.dspDoDRMAN" />
<cfset xfa.dspDoDRMANSH = "ah.dspDoDRMANSH" />
<cfset xfa.bkupactDoDSaveSearch = "ah.bkupactDoDSaveSearch" />
<cftry>
<cfsavecontent variable="request.content"><cfoutput><cfinclude template="../adhocReports/qryDoDResults.cfm"></cfoutput></cfsavecontent>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 17 and right(cfcatch.MissingFileName,17) is "qryDoDResults.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse qryDoDResults.cfm in circuit ah which does not exist (from fuseaction ah.getDoDResults).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cftry>
<cfsavecontent variable="request.content"><cfoutput><cfinclude template="../adhocReports/dspDoDResults.cfm"></cfoutput></cfsavecontent>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 17 and right(cfcatch.MissingFileName,17) is "dspDoDResults.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse dspDoDResults.cfm in circuit ah which does not exist (from fuseaction ah.getDoDResults).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cftry>
<cfoutput><cfinclude template="../adhocReports/../layDefault.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 17 and right(cfcatch.MissingFileName,17) is "../layDefault.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse ../layDefault.cfm in circuit ah which does not exist (from fuseaction ah.getDoDResults).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfcatch><cfrethrow></cfcatch>
</cftry>

