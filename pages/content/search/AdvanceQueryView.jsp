<%@ page import="java.util.*"%>
<%@ page import="edu.wustl.catissuecore.util.global.Constants"%>
<%@ page import="edu.wustl.common.util.SearchUtil"%>

<head>

	<link rel="StyleSheet" href="tree.css" type="css/tree.css">
	<script type="text/javascript" src="jss/tree.js"></script>
	<LINK REL="StyleSheet" HREF="css/menu.css">
	<script language="javascript" src="jss/menu.js"></script>
	<script type="text/javascript">
	<%
		Vector Treelist = (Vector)request.getAttribute("vector");
	%>
	var Tree = [<%int k;%><%for (k=0;k < (Treelist.size()-1);k++){%>"<%=Treelist.get(k)%>",<%}%>"<%=Treelist.get(k)%>"];
	//window.onload=TreeContent(Treelist);
	<% SearchUtil util = new SearchUtil(); %>
	/*function TreeContent(list){
		alert('im in treecontent');
		
		var Tree = new Array;
		for(var i = 0; i < list.size(); i++){
        	Tree[i] = list.get(i);
        }
       createTree(Tree); 
	}*/
	
	var itemCount = 1;
	
	
	function CheckNum(checkName,itemName,nodeCount){
	
		if(document.getElementById(checkName).checked==true){
			DisableAll();
			if(itemName == '<%=Constants.PARTICIPANT%>'){
				itemCount++;
			}
			if(itemName == '<%=Constants.COLLECTION_PROTOCOL%>'){
				itemCount++;
			}
			if(itemName == '<%=Constants.DISTRIBUTION_PROTOCOL%>'){
				itemCount++;
			}
			if((itemName == '<%=Constants.SPECIMEN_COLLECTION_GROUP%>') || (itemName == '<%=Constants.DISTRIBUTION%>') ){
				itemCount++;
			}
			if(itemName == '<%=Constants.SPECIMEN%>')
				itemCount++;
		}
		else
			itemCount--;
			
	//if(itemCount > 2){
		//DisableAll();
	//}
	//else{
		if(itemCount == 1){
			DisableAll();
			var item = document.getElementById('<%=Constants.P%>');
			item.className="linkChange";
			item.innerHTML = "&nbsp;<img src='images/Participant.GIF' alt='Participant' /> &nbsp;<a HREF='<%=util.getLink("Participant")%>' target='searchPageFrame'><%=Constants.PARTICIPANT%></a>";
		}
		//Poornima:Added CP link
		if(itemCount == 2){
			DisableAll();
			var item = document.getElementById('<%=Constants.CP%>');
			item.className="linkChange";
			item.innerHTML = "&nbsp;<img src='images/CollectionProtocol.GIF' alt='CollectionProtocol' />  &nbsp;<a HREF='<%=util.getLink("CollectionProtocol")%>' target='searchPageFrame'><%=Constants.COLLECTION_PROTOCOL%></a>";
		}
		else
			EnableItem(nodeCount);
		//}
	}	

	function DisableAll(){
		var item = document.getElementById('<%=Constants.CP%>');
		item.className="linkChange";
		item.innerHTML = "&nbsp;<img src='images/CollectionProtocol.GIF' alt='CollectionProtocol' />  &nbsp;<%=Constants.COLLECTION_PROTOCOL%>";
		
		item = document.getElementById('<%=Constants.DP%>');
		item.className="linkChange";
		item.innerHTML = "&nbsp;<img src='images/DistributionProtocol.GIF' alt='DistributionProtocol' /> &nbsp; <%=Constants.DISTRIBUTION_PROTOCOL%>";
		
		item = document.getElementById('<%=Constants.P%>');
		item.className="linkChange";
		item.innerHTML = "&nbsp;<img src='images/Participant.GIF' alt='Participant' /> &nbsp;<%=Constants.PARTICIPANT%>";
		
		item = document.getElementById('<%=Constants.S%>');
		item.className="linkChange"
		item.innerHTML = "&nbsp;<img src='images/Specimen.GIF' alt='Specimen' /> &nbsp; <%=Constants.SPECIMEN%>";
		
		item = document.getElementById('<%=Constants.SCG%>');
		item.className="linkChange";
		item.innerHTML = "&nbsp;<img src='images/SpecimenCollectionGroup.GIF' alt='Specimen Collection Group' /> &nbsp;<%=Constants.SPECIMEN_COLLECTION_GROUP%>";
		
		item = document.getElementById('<%=Constants.D%>');
		item.className="linkChange";
		item.innerHTML = "&nbsp;<img src='images/Distribution.GIF' alt='Distribution' /> &nbsp; <%=Constants.DISTRIBUTION%>";
		
		
	}
	
	function EnableAll(){
	
		var item = document.getElementById('<%=Constants.CP%>');
		item.className="linkChange";
		item.innerHTML = "&nbsp;<img src='images/CollectionProtocol.GIF' alt='CollectionProtocol' />  &nbsp;<a HREF='#'><%=Constants.COLLECTION_PROTOCOL%></a>";;
		
		item = document.getElementById('<%=Constants.P%>');
		item.className="linkChange";
		item.innerHTML = "&nbsp;<img src='images/Participant.GIF' alt='Participant' /> &nbsp;<a HREF='<%=util.getLink("Participant")%>' target='searchPageFrame'><%=Constants.PARTICIPANT%></a>";
		
		item = document.getElementById('<%=Constants.S%>');
		item.className="linkChange"
		item.innerHTML = "&nbsp;<img src='images/Specimen.GIF' alt='Specimen' /> &nbsp; <a HREF='#'><%=Constants.SPECIMEN%></a>";
		
		item = document.getElementById('<%=Constants.SCG%>');
		item.className="linkChange";
		item.innerHTML = "&nbsp;<img src='images/SpecimenCollectionGroup.GIF' alt='Specimen Collection Group' /> &nbsp;<a HREF='#'><%=Constants.SPECIMEN_COLLECTION_GROUP%></a>";
		
		item = document.getElementById('<%=Constants.D%>');
		item.className="linkChange";
		item.innerHTML = "&nbsp;<img src='images/Distribution.GIF' alt='Distribution' /> &nbsp; <a HREF='#'><%=Constants.DISTRIBUTION%></a>";
		
		item = document.getElementById('<%=Constants.DP%>');
		item.className="linkChange";
		item.innerHTML = "&nbsp;<img src='images/DistributionProtocol.GIF' alt='DistributionProtocol' /> &nbsp; <a HREF='#'><%=Constants.DISTRIBUTION_PROTOCOL%></a>";
	}
	
	function EnableItem(nodeCount){
		var count1 = 0;
		var count2 = 0;
		var count3 = 0;
		var count4 = 0;
		var count5 = 0;
							
		for(var i = 1; i <= nodeCount; i++){
			
			var item1 = '<%=Constants.PARTICIPANT%>'+"_"+i;
			
			if((document.getElementById(item1) != null) && (document.getElementById(item1).checked==true)){
				var item = document.getElementById('<%=Constants.CP%>');
				item.className="linkChange";
				item.innerHTML ="&nbsp;<img src='images/CollectionProtocol.GIF' alt='CollectionProtocol' />  &nbsp;<a HREF='#'><%=Constants.COLLECTION_PROTOCOL%></a>";
			
				item = document.getElementById('<%=Constants.DP%>');
				item.className="linkChange";
				item.innerHTML = "&nbsp;<img src='images/DistributionProtocol.GIF' alt='DistributionProtocol' /> &nbsp; <a HREF='#'><%=Constants.DISTRIBUTION_PROTOCOL%></a>";
				count1++;
				
			}
			
			var item2 = '<%=Constants.COLLECTION_PROTOCOL%>'+"_"+i;
			if((document.getElementById(item2)!= null) && (document.getElementById(item2).checked==true)){
				//temporary comment by Poornima
				/*var item = document.getElementById('<%=Constants.SCG%>');
				item.className="linkChange";
				item.innerHTML ="&nbsp;<img src='images/SpecimenCollectionGroup.GIF' alt='Specimen Collection Group' /> &nbsp;<a HREF='#'><%=Constants.SPECIMEN_COLLECTION_GROUP%></a>";*/
				var item = document.getElementById('<%=Constants.S%>');
				item.className="linkChange";
				item.innerHTML ="&nbsp;<img src='images/Specimen.GIF' alt='Specimen' /> &nbsp; <a HREF='#'><%=Constants.SPECIMEN%></a>";
				count2++;
				
			}
			
			var item3 = '<%=Constants.DISTRIBUTION_PROTOCOL%>'+"_"+i;
			if((document.getElementById(item3)!= null) && (document.getElementById(item3).checked==true)){
				var item = document.getElementById('<%=Constants.D%>');
				item.className="linkChange";
				item.innerHTML ="&nbsp;<img src='images/Distribution.GIF' alt='Distribution' /> &nbsp; <a HREF='#'><%=Constants.DISTRIBUTION%></a>";
				count3++;
			}
			
			var item4 = '<%=Constants.SPECIMEN_COLLECTION_GROUP%>'+"_"+i;
			var item5 = '<%=Constants.DISTRIBUTION%>'+"_"+i;
			if(((document.getElementById(item4)!= null) && (document.getElementById(item4).checked==true)) ||((document.getElementById(item5)!= null) && (document.getElementById(item5).checked==true))){
				var item = document.getElementById('<%=Constants.S%>');
				item.className="linkChange";
				item.innerHTML ="&nbsp;<img src='images/Specimen.GIF' alt='Specimen' /> &nbsp; <a HREF='#'><%=Constants.SPECIMEN%></a>";
				count4++;
			}
			
			var item6 = '<%=Constants.SPECIMEN%>'+"_"+i;
			if((document.getElementById(item6)!= null) && (document.getElementById(item6).checked==true)){
			//temporary comment by Poornima
				/*var item = document.getElementById('<%=Constants.S%>');
				item.className="linkChange";
				item.innerHTML ="&nbsp;<img src='images/Specimen.GIF' alt='Specimen' /> &nbsp; <a HREF='#'><%=Constants.SPECIMEN%></a>";*/
				var item = document.getElementById('<%=Constants.SCG%>');
				item.className="linkChange";
				item.innerHTML ="&nbsp;<img src='images/SpecimenCollectionGroup.GIF' alt='Specimen Collection Group' /> &nbsp;<a HREF='#'><%=Constants.SPECIMEN_COLLECTION_GROUP%></a>";
				count5++;
			}
			
		}
		var sum = count1 + count2 + count3 + count4 + count5;
		if( (count1 == sum) || (count2 == sum) || (count3 == sum) || (count4 == sum) ||(count5 == sum) )
			return;
		else
			DisableAll();
		
	}	
	</script>
</head>



<html>
<body>
	
	<table cellpadding='0' cellspacing='0' border='0' width='600'>
		<tr>
			<td class='formTitle' height='20' width='72%'>
				<img src="images/arrow.GIF" alt="Rules" />Rules
			</td>
			<td class='formTitle'  height='20' width='8%' onmouseover="expand(this);" onmouseout="collapse(this);" align='centre'>Add 
				<table class='menuNormal' border='0' cellpadding='0' cellspacing='0'>
					<tr>
						<td>
							<div class='menuNormal' width='140'>
								<table class='menuNormal' width='140' border='0' cellpadding='3' cellspacing='1'>
									<tr height='20'  vAlign="middle">
										<td colspan=2 class='linkChange' id='P' noWrap  height='20' vAlign="middle"
										onmouseover="changeMenuStyle(this,'linkChangeOnMouseOver')"
										 onmouseout="changeMenuStyle(this,'linkChange')">
											&nbsp;<img src="images/Participant.GIF" alt="Participant" /> &nbsp; 
											<a HREF='<%=util.getLink("Participant")%>' target="searchPageFrame">
												<%=Constants.PARTICIPANT%>
											</a>
										</td>
									</tr>
									<tr height='20' vAlign="middle">
										<td colspan=2 class='linkChange' id='CP' noWrap  height='20' vAlign="middle"
										onmouseover="changeMenuStyle(this,'linkChangeOnMouseOver')"
										 onmouseout="changeMenuStyle(this,'linkChange')">
												&nbsp;<img src="images/CollectionProtocol.GIF" alt="CollectionProtocol" />  &nbsp;	<%=Constants.COLLECTION_PROTOCOL%>
										</td>
									</tr>
									<tr height='20' vAlign="middle">
										<td colspan=2 class='linkChange' id='S' noWrap  height='20' vAlign="middle"
										onmouseover="changeMenuStyle(this,'linkChangeOnMouseOver')"
										 onmouseout="changeMenuStyle(this,'linkChange')">
											&nbsp;<img src="images/Specimen.GIF" alt="Specimen" /> &nbsp; <%=Constants.SPECIMEN%>
										</td>
									</tr>
									<tr height='20' vAlign="middle">
										<td colspan=2 class='linkChange' id='SCG' noWrap  height='20' vAlign="middle"
										onmouseover="changeMenuStyle(this,'linkChangeOnMouseOver')"
										 onmouseout="changeMenuStyle(this,'linkChange')">
											&nbsp;<img src="images/SpecimenCollectionGroup.GIF" alt="Specimen Collection Group" /> &nbsp; <%=Constants.SPECIMEN_COLLECTION_GROUP%>
										</td>
									</tr>
									<tr height='20' vAlign="middle">
										<td colspan=2 class='linkChange' id='D' noWrap  height='20' vAlign="middle"
										onmouseover="changeMenuStyle(this,'linkChangeOnMouseOver')"
										 onmouseout="changeMenuStyle(this,'linkChange')">
										&nbsp;<img src="images/Distribution.GIF" alt="Distribution" /> &nbsp; <%=Constants.DISTRIBUTION%>
										</td>
									</tr>
									<tr height='20' vAlign="middle">
										<td colspan=2 class='linkChange' id='DP' noWrap  height='20' vAlign="middle"
										onmouseover="changeMenuStyle(this,'linkChangeOnMouseOver')"
										 onmouseout="changeMenuStyle(this,'linkChange')">
										&nbsp;<img src="images/DistributionProtocol.GIF" alt="DistributionProtocol" /> &nbsp; <%=Constants.DISTRIBUTION_PROTOCOL%>
										</td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
			</table>
			</td>
		<td class='formTitle' height='20' width='10%'>Edit</td>
		<td class='formTitle' height='20' width='10%'>Delete</td>
	</tr>

	
		<div class="tree">
			<script type="text/javascript">
				createTree(Tree);
			</script>
		</div>
	
	</table>	
	</body>
</html>

