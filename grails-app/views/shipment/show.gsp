
<%@ page import="org.pih.warehouse.ContainerType" %>
<%@ page import="org.pih.warehouse.Document" %>
<%@ page import="org.pih.warehouse.DocumentType" %>
<%@ page import="org.pih.warehouse.EventType" %>
<%@ page import="org.pih.warehouse.Product" %>
<%@ page import="org.pih.warehouse.Location" %>
<%@ page import="org.pih.warehouse.Shipment" %>
<%@ page import="org.pih.warehouse.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="custom" />
        <g:set var="entityName" value="${message(code: 'shipment.label', default: 'Shipment')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>        
        <!-- Specify content to overload like global navigation links, page titles, etc. -->
		<content tag="pageTitle">
			<g:if test="${shipmentInstance?.name}">${shipmentInstance?.name}</g:if>
			<g:else><g:message code="default.show.label" args="[entityName]" /></g:else>
		</content>
		<content tag="menuTitle">${entityName}</content>		
		<content tag="globalLinksMode">append</content>
		<content tag="localLinksMode">override</content>
		<content tag="globalLinks"><g:render template="global" model="[entityName:entityName]"/></content>
		<content tag="localLinks"><g:render template="local" model="[entityName:entityName]"/></content>    
				
    	<script type="text/javascript" src="${createLinkTo(dir:'js/yui/2.7.0/yahoo-dom-event',file:'yahoo-dom-event.js')}" charset="utf-8"></script>
    	<script type="text/javascript" src="${createLinkTo(dir:'js/yui/2.7.0/container',file:'container.js')}" charset="utf-8"></script>
		<script type="text/javascript" src="${createLinkTo(dir:'js/yui/2.7.0/element',file:'element-min.js')}"></script>
		<script type="text/javascript" src="${createLinkTo(dir:'js/yui/2.7.0/tabview',file:'tabview-min.js')}"></script>
		<script type="text/javascript" src="${createLinkTo(dir:'js/yui/2.7.0/history',file:'history-min.js')}"></script>
		
		<%-- 
		<link type="text/css" href="${createLinkTo(dir:'js/jquery.ui/css/cupertino',file:'jquery-ui-1.8.2.custom.css')}" rel="stylesheet" />
		<script type="text/javascript" src="${createLinkTo(dir:'js/jquery.ui',file:'jquery-1.4.2.min.js')}"></script>
		<script type="text/javascript" src="${createLinkTo(dir:'js/jquery.ui',file:'jquery-ui-1.8.2.custom.min.js')}"></script>
		--%>
	
	    <style type="text/css" media="screen">
	    	table {
	    		background-color: white; 	    	
	    	} 
	        .container {
	            width: 100%;
	        }
	
            .container h2 {
                font-size: 136%;
                font-weight: bold;
            }
	
			.switcher a {
			    display: block;
			    float: right;
			    font-weight: normal;
			    text-decoration: none;
			}

             .module {
                padding: 5px;
            }
            #yui-history-iframe {
			  position:absolute;
			  top:0; left:0;
			  width:1px; height:1px; /* avoid scrollbars */
			  visibility:hidden;
			}
			#edit-details-link, #edit-origin-link, #edit-destination-link { 
				padding:0.4em 1em 0.4em 20px;
				position:relative;
				text-decoration:none;           
				/*background-color: #eee;
				border: 1px solid #ccc;*/ 
			}            
            
	    </style>
	    
		
	    
	    
    </head>
    <body>
        <div class="body" style="width:100%;">
          	<iframe id="yui-history-iframe" src="assets/blank.html"></iframe>
			<input id="yui-history-field" type="hidden">
          
            <g:if test="${flash.message}">
           		<div class="message">${flash.message}</div>
            </g:if>            

			<div id="dialogBanner">
				<span class="title">Shipment Summary</span>
				<%-- 
				<span class="listcontainer" style="float:right; text-align:right; ">				
					<ul class="list">						
						<li class="first active"><span class="large">show</span></li>
						<li><g:link action="edit" id="${shipmentInstance?.id}"><span class="large">edit</span></g:link></li>	
					</ul>
				</span>
				--%>
			</div>	
			<div id="shipment" style="border: 1px solid black;">
								
				<div id="summary">
					<table border="0" width="100%">
	                    <tbody>       
	                    	<tr>
	                    		<td width="50%">
									<table>
					                	<tbody>     	
					                        <tr class="prop">
					                            <td valign="top" class="name"><label><g:message code="shipment.origin.label" default="Origin" /></label></td>
					                            <td valign="top" class="value" nowrap="nowrap">
					                            	<div class="switcher">
					                            		<!-- removed span because of rendering issue <span class="ui-icon ui-icon-newwin"></span> 
					                            				<a ... class="ui-state-default ui-corner-all">
					                            		-->
						                            	<a href="#" id="edit-origin-link"><img src="${createLinkTo(dir:'images/icons/silk',file:'page_edit.png')}" alt="Edit Origin"/></a>
					                            	</div>					             
					                            	<div id="view-origin">
						                            	<h3>${shipmentInstance?.origin?.encodeAsHTML()}</h3>	                            
						                            	${shipmentInstance?.origin?.address?.address}<br/>
						                            	${shipmentInstance?.origin?.address?.city}
						                            	${shipmentInstance?.origin?.address?.stateOrProvince} 
						                            	${shipmentInstance?.origin?.address?.postalCode} <br/>
						                            	${shipmentInstance?.origin?.address?.country} <br/>
					                            	</div>					                            	
					                            	<div id="edit-origin" style="display:none;">
						                            	<g:form method="post">
											                <g:hiddenField name="id" value="${shipmentInstance?.id}" />
											                <g:hiddenField name="version" value="${shipmentInstance?.version}" />
							                            	<span class=" ${hasErrors(bean: shipmentInstance, field: 'origin', 'errors')}">
							                					<g:select name="origin.id" from="${org.pih.warehouse.Warehouse.list()}" optionKey="id" value="${shipmentInstance?.origin?.id}"  />						                					
															</span>
															<span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.save.label', default: 'Save')}" /></span>
														</g:form>
					                            	</div>
					                            </td>                            
					                        </tr>                    
					                    </tbody>
					                </table>
	                    		</td>
	                    		<td width="50%">
									<table>
					                	<tbody>     	
					                        <tr class="prop">
					                            <td valign="top" class="name"><label><g:message code="shipment.destination.label" default="Destination" /></label></td>
					                            
					                            <td valign="top" class="value" nowrap="nowrap">
					                            	<div class="switcher"><!-- class="ui-state-default ui-corner-all" -->
						                            	<a href="#" id="edit-destination-link"><img src="${createLinkTo(dir:'images/icons/silk',file:'page_edit.png')}" alt="Edit Destination"/></a>
					                            	</div>
					                            
					                            
					                            	<div id="view-destination">
						                            	<h3>${shipmentInstance?.destination?.encodeAsHTML()}</h3>
						                            	${shipmentInstance?.destination?.address?.address}<br/>
						                            	${shipmentInstance?.destination?.address?.city}
						                            	${shipmentInstance?.destination?.address?.stateOrProvince} 
						                            	${shipmentInstance?.destination?.address?.postalCode} <br/>
						                            	${shipmentInstance?.destination?.address?.country} <br/>
						                            </div>
					                            	<div id="edit-destination" style="display:none;">
					                            	
						                            	<g:form method="post">
											                <g:hiddenField name="id" value="${shipmentInstance?.id}" />
											                <g:hiddenField name="version" value="${shipmentInstance?.version}" />
							                            	<span class=" ${hasErrors(bean: shipmentInstance, field: 'destination', 'errors')}">
							                					<g:select name="destination.id" from="${org.pih.warehouse.Warehouse.list()}" optionKey="id" value="${shipmentInstance?.destination?.id}"  />								                					
															</span>
															<span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.save.label', default: 'Save')}" /></span>
														</g:form>
					                            	</div>
					                            </td>  
					                        </tr>
					                    </tbody>
					                </table>
	                    		</td>	                    	
	                    	</tr>
	                    </tbody>
	                </table>			
	            </div>



	            
	            <div id="details">
					<gui:tabView id="shipmentTabs">
					
					
					
					
					
					
					
					    <gui:tab id="shipmentDetailsTab" label="Details" active="true">				    
							<h2><g:message code="shipment.method.label" default="Shipping Method" /></h2>
				            <div id="detailsTab" class="tab" >
				            	<div class="switcher"><!-- class="ui-state-default ui-corner-all" -->
					            	<a href="#" id="edit-details-link" ><img src="${createLinkTo(dir:'images/icons/silk',file:'page_edit.png')}" alt="Edit Details"/></a>
				                </div>			                
				            	<div id="view-details" style="background-color: white;">				            		
									<table class="withoutBorder" border="0">
					                    <tbody>       
					                        <tr class="prop">
					                            <td valign="middle" class="name"><label><g:message code="shipment.shipmentStatus.label" default="Status" /></label></td>                            
					                            <td valign="top" class="value" nowrap="nowrap">
					                            	${fieldValue(bean: shipmentInstance, field: "shipmentStatus.name")}
					                            </td>                            
					                        </tr>                    

					                        <tr class="prop">
					                            <td valign="middle" class="name">
					                            	<label><g:message code="shipment.name.label" default="Nickname" /></label>
					                            </td>                            
					                            <td valign="top" class="value" nowrap="nowrap">
					                            	${fieldValue(bean: shipmentInstance, field: "name")}
					                            </td>                            
					                        </tr>                    
					                        <tr class="prop">
					                            <td valign="middle" class="name">
					                            	<label><g:message code="shipment.description.label" default="Description" /></label>
					                            </td>                            
					                            <td valign="top" class="value" nowrap="nowrap">
					                            	${fieldValue(bean: shipmentInstance, field: "description")}
					                            </td>                            
					                        </tr>                    
					                    
					                    
											<tr class="prop">
												<td valign="top" class="name"><label><g:message code="shipment.expectedShippingDate.label" default="Ship date" /></label></td>                            
												<td valign="top" class="value" nowrap="nowrap">
													<g:formatDate date="${shipmentInstance?.expectedShippingDate}" format="dd MMM yyyy"/>
												</td>
											</tr>
											<tr class="prop">
												<td valign="top" class="name"><label><g:message code="shipment.expectedDeliveryDate.label" default="Delivery date" /></label></td>   
												<td valign="top" class="value" nowrap="nowrap">
													<g:formatDate date="${shipmentInstance?.expectedDeliveryDate}" format="dd MMM yyyy"/>
												</td>
											</tr>
				           					<tr class="prop">	                        	
					                            <td valign="top" class="name"><label><g:message code="shipment.method.label" default="Shipment method" /></label></td>        
					                            <td valign="top" class="value">
					                  				<img src="${createLinkTo(dir:'images/icons',file: shipmentInstance?.shipmentMethod?.methodName + '.png')}" valign="top"/>          	
					                            	${fieldValue(bean: shipmentInstance, field: "shipmentMethod.name")}
					                            	
					                            </td>
					                        </tr>                    
					                        <tr class="prop">
					                            <td valign="top" class="name"><label><g:message code="shipment.trackingNumber.label" default="Tracking number" /></label></td>                            
					                            <td valign="top" class="value">
					                            	${fieldValue(bean: shipmentInstance, field: "trackingNumber")}&nbsp;
					                            	<g:if test="${shipmentInstance.trackingNumber}">
						                            	(<a href="${fieldValue(bean: shipmentInstance, field: "shipmentMethod.trackingUrl")}${fieldValue(bean: shipmentInstance, field: "trackingNumber")}" 
						                            		target="_blank">track</a>)	
					                            	</g:if>
					                            </td>               
					                        </tr>  	       					                    	
								
											<g:each in="${shipmentInstance.referenceNumbers}" var="referenceNumber" status="status">
												<tr class="prop">
													<td valign="top" class="name"><label>${referenceNumber?.referenceNumberType?.name}</label></td>   
													<td valign="top" class="value">
														${referenceNumber?.identifier}	
													</td>                          
												</tr>												 													
											</g:each>
											<%-- 
											<tr class="prop">
											    <td valign="top" class="name"><label><g:message code="shipment.comments.label" default="Comments" /></label></td>   
											    <td valign="top" class="value" nowrap="nowrap">											    	
											    	<g:if test="${shipmentInstance?.comments}">
											    		<ul>
												    		<g:each in="${shipmentInstance.comments}" var="comment" status="status">
																<li>${comment?.comment}</li>
															</g:each>
														</ul>
											    	</g:if>
											    	<g:else>No comments</g:else>
											    </td>                          
											</tr>		
											--%>		             
					                    </tbody>
					                </table>	
					        	</div>
					        	<div id="edit-details" style="display: none;">
									<g:form method="post">
						                <g:hiddenField name="id" value="${shipmentInstance?.id}" />
						                <g:hiddenField name="version" value="${shipmentInstance?.version}" />
						                <table class="withoutBorder" border="0">
						                    <tbody>	            
						                    
						                        <tr class="prop">
						                            <td valign="top" class="name">
						                            	<label><g:message code="shipment.name.label" default="Nickname" /></label>
						                           	</td>           
						                            <td colspan="3" valign="top" class="value ${hasErrors(bean: shipmentInstance, field: 'name', 'errors')}">
					                                    <g:textField name="name" size="60" value="${shipmentInstance?.name}" />
						                            </td>                            
						                        </tr>                    
						                        <tr class="prop">
						                            <td valign="top" class="name">
						                            	<label><g:message code="shipment.name.label" default="Describe what you are shipping" /></label>
						                            </td>                            
						                            <td colspan="3" valign="top" class="value ${hasErrors(bean: shipmentInstance, field: 'description', 'errors')}">
														<g:textArea name="description" value="${shipmentInstance?.description}" rows="3" cols="60"/>
						                            </td>                            
						                        </tr>                    
						                        <tr class="prop">
						                            <td valign="middle" class="name"><label><g:message code="shipment.shipmentStatus.label" default="Current status" /></label></td>                            
						                            <td valign="middle" class="value" nowrap="nowrap">
								                    	<g:select name="shipmentStatus.id" from="${org.pih.warehouse.ShipmentStatus.list()}" optionKey="id" value="${shipmentInstance?.shipmentStatus?.id}"  /> 
						                            </td>                            
						                        </tr>                    						                                
												<tr class="prop">
													<td valign="top" class="name"><label><g:message code="shipment.expectedShippingDate.label" default="Ship date" /></label></td>                            
					                                <td valign="top" class=" ${hasErrors(bean: shipmentInstance, field: 'expectedShippingDate', 'errors')}" nowrap="nowrap">
						           						<g:datePicker name="expectedShippingDate" precision="day" value="${shipmentInstance?.expectedShippingDate}" />
					                                </td>
												</tr>
												<tr class="prop">
													<td valign="top" class="name"><label><g:message code="shipment.expectedDeliveryDate.label" default="Delivery date" /></label></td>   
					                                <td valign="top" class=" ${hasErrors(bean: shipmentInstance, field: 'expectedDeliveryDate', 'errors')}" nowrap="nowrap">
						           						<g:datePicker name="expectedDeliveryDate" precision="day" value="${shipmentInstance?.expectedDeliveryDate}" />
					                                </td>
												</tr>
					           					<tr class="prop">	                        	
						                            <td valign="top" class="name"><label><g:message code="shipment.method.label" default="Shipment method" /></label></td>        
						                            <td valign="top" class="value ${hasErrors(bean: shipmentInstance, field: 'shipmentMethod', 'errors')}">
														<g:select name="shipmentMethod.id" from="${org.pih.warehouse.ShipmentMethod.list()}" optionKey="id" optionValue="name" value="${shipmentInstance?.shipmentMethod?.id}"  />
						                            </td>
						                        </tr>                    
						                        <tr class="prop">
						                            <td valign="top" class="name"><label><g:message code="shipment.trackingNumber.label" default="Tracking number" /></label></td>                            
						                            <td valign="top" class="value ${hasErrors(bean: shipmentInstance, field: 'trackingNumber', 'errors')}">
					                                    <g:textField name="trackingNumber" value="${shipmentInstance?.trackingNumber}" />
					                                </td>
						                        </tr>  	 
						                        
						                        <%--    						                    	
												<tr class="prop">
													<td valign="top" class="name"><label><g:message code="shipment.referenceNumbers.label" default="Reference Numbers" /></label></td>   
													<td valign="top" class="value">

													</td>                          
												</tr>
												<tr class="prop">
												    <td valign="top" class="name"><label><g:message code="shipment.comments.label" default="Comments" /></label></td>   
												    <td valign="top" class="value" nowrap="nowrap">

												    </td>                          
												</tr>
												--%>
													
												<tr class="prop">		                        
						                        	<td></td>
						                        	<td>
														<div class="buttons">
															<button type="submit" class="positive"><img src="${createLinkTo(dir:'images/icons/silk',file:'tick.png')}" alt="save" /> Save</button>
															<a href="#" class="negative"> <img src="${createLinkTo(dir:'images/icons/silk',file:'cancel.png')}" alt="" /> Cancel </a>
														</div>
													</td>		                        
						                        </tr>													
											</tbody>
										</table>											
						 			</g:form>						        							        		
					        	</div>							
							</div>												
					    </gui:tab>		
					    

						<gui:tab id="shipmentEventsTab" label="Events">
							<h2><g:message code="shipment.events.label" default="Tracking" /></h2>
							<div id="eventsTab" class="tab">
								<g:if test="${!shipmentInstance.events}">	
									<div class="notice">
										<span style="padding-right: 15px;">There are no events for this shipment.</span>
										<a href="#" id="add-event-link">Add a new event</a>										
									</div>
								</g:if>
								<g:else>							
									<table>
										<thead>
				                       		<tr>
				                       			<th width="5%"></th>
				                       			<th>Date</th>
				                       			<th>Activity</th>
				                       			<th>Location</th>
				                       			<th width="5%"></th>
				                       		</tr>
				                       	</thead>
				                       	<tbody>
										    <g:each in="${shipmentInstance.events}" var="event" status="i">
												<tr id="event-${event.id}" class="${(i % 2) == 0 ? 'odd' : 'even'}">
													<td><img src="${createLinkTo(dir:'images/icons',file:'event.png')}" alt="Event" /></td>
													<td><g:formatDate format="dd MMM yyyy hh:mm:ss" date="${event?.eventDate}"/></td>
													<td>${event?.eventType?.name}</td>
													<td>${event?.eventLocation?.name}</td>
													<td>
														<g:link action="deleteEvent" id="${event?.id}">
															<img src="${createLinkTo(dir:'images/icons',file:'trash.png')}" alt="Delete Event"/>
														</g:link>
													</td>
												</tr>
										    </g:each>
											<g:form action="addEvent">
												<g:hiddenField name="shipmentId" value="${shipmentInstance?.id}" />
											    <tr>
													<td></td>
													<td>
														<g:datePicker id="eventDate" name="eventDate" value="" />
													</td>
													<td>
														<g:select id="eventTypeId" name='eventTypeId' noSelection="${['':'Select one ...']}" from='${EventType.list()}' optionKey="id" optionValue="name"></g:select>
													</td>
													<td>
														<g:select id="eventLocationId" name='eventLocationId' noSelection="${['':'Select one ...']}" from='${Location.list()}' optionKey="id" optionValue="name"></g:select>									
													</td>
													<%-- 
													<td>
														<g:select id="targetLocationId" name='targetLocationId' noSelection="${['':'Select one ...']}" from='${Location.list()}' optionKey="id" optionValue="name">
														</g:select>									
													</td>									
													<td>
														<g:textField name="description" size="15" /> 
												    </td>
												    --%>
												    <td>
														<div class="buttons">
															<button type="submit" class="positive"><img src="${createLinkTo(dir:'images/icons/silk',file:'tick.png')}" alt="save" /> Save</button>
															<a href="#" class="negative"> <img src="${createLinkTo(dir:'images/icons/silk',file:'cancel.png')}" alt="" /> Cancel </a>
															
														</div>
													</td>
													
													
												</tr>
										    </g:form>										    
										    
										</tbody>
					                </table>
					            </g:else>
					    	</div>
					    </gui:tab>
						
											
						<gui:tab id="shipmentPiecesTab" label="Pieces">
							<h2><g:message code="shipment.pieces.label" default="Shipment Pieces" /></h2>
							<div id="itemsTab" class="tab">
								<g:if test="${shipment?.description}">
									<table class="withoutBorder">
										<tbody>
											<tr class="prop">
											    <td valign="top" class="name"><label><g:message code="shipment.description.label" default="Description" /></label></td>   
											    <td valign="top" class="value" nowrap="nowrap">
													${shipment?.description}
											    </td>                          
											</tr>	 	
										</tbody>
									</table>
								</g:if>
								<g:if test="${!shipmentInstance.containers}">	
									<div class="notice">
										There are no pieces in this shipment.
										<a href="#" id="add-container-link">Add a new piece</a>						    										
									</div>								
								</g:if>
								<g:else>
								    <g:each in="${shipmentInstance.containers}" var="container" status="c">
									    <table style="background-color: white;" border="0">
											<tbody>
												<tr>
													<td valign="top">
														<div style="margin-top: 10px; margin-bottom: 10px;">
															<span style="font-size: 1.2em">
																<img src="${createLinkTo(dir:'images/icons',file:'box_24.gif')}" alt="box" />
																 #${c+1} <g:if test='${container.name}'><b>${container?.name}</b></g:if>
															</span>
															<span>
																&nbsp;|&nbsp;
																Type: ${container?.containerType?.name } &nbsp;|&nbsp;  
																Weighs: ${container?.weight} ${container?.units} &nbsp;|&nbsp;  
																Contains: <%= container.getShipmentItems().size() %> items &nbsp;|&nbsp;
																<a href="#" id="show-container-contents-link-${container?.id}">Show Contents</a>										
																
															</span> 
														</div>
													</td>		
													<td width="10%" valign="top" >
														<div style="margin-top: 10px; margin-bottom: 10px; text-align: right">
															<a href="#" id="copy-container-link-${container?.id}">
																<img src="${createLinkTo(dir:'images/icons/silk',file:'page_copy.png')}" alt="Copy Container"/>
															</a>															
															<g:link action="deleteContainer" id="${container?.id}">
																<img src="${createLinkTo(dir:'images/icons',file:'trash.png')}" alt="Delete Container"/>
															</g:link>
														</div>
													</td>						
												</tr>
											</tbody>
										</table>										
										<div id="container-contents-${container?.id}" style="display: none">
											<table>
												<tbody>
													<tr>
														<td align="center" colspan="2">
										                    <table class="withBorder">
										                       	<thead>
										                       		<tr>
										                       			<th width="5%"></th>
										                       			<th width="40%">Cargo</th>
										                       			<th width="20%">Quantity</th>
										                       			<th width="20%">Weight</th>
										                       			<th width="5%"></th>
										                       		</tr>
										                       	</thead>
																<tbody>
																	<g:if test="${!container.shipmentItems}">	
																	 	<%--
																	 	<tr class="odd">
																	 		<td colspan="5">
																		 		There are no shipping items in this ${container.containerType.name}.	
																		 	</td>
																		</tr>
																		 --%>
																		<tr class="odd">
																			<td width="1%"><img src="${createLinkTo(dir:'images/icons',file:'pill.png')}" alt="Product" /></td>																	
																			<td colspan="5"> 
																		 		<a href="#" id="add-item-link-${container?.id}">Add a new item</a>																	
																	 		</td>
																	 	</tr>
																	</g:if>
																	<g:else>					
																	    <g:each in="${container.shipmentItems}" var="item" status="i">
																			<tr id="item-${item.id}" class="${(i % 2) == 0 ? 'odd' : 'even'}">
																				<td width="1%"><img src="${createLinkTo(dir:'images/icons',file:'pill.png')}" alt="Item" /></td>
																				<td>
																					${item?.product.name} 			
																				</td>
																				<td>
																					${item?.quantity} units									
																				</td>
																				<td>
																					${item?.grossWeight}									
																				</td>
																				<td>
																					<g:link class="remove" action="deleteItem" id="${item?.id}">
																						<img src="${createLinkTo(dir:'images/icons',file:'trash.png')}" alt="Delete Shipment Item"/>
																					</g:link>
																				</td>
																			</tr>																	
																	    </g:each>
																	    <tr class="odd">
																			<td width="1%"><img src="${createLinkTo(dir:'images/icons',file:'product.png')}" alt="Item" /></td>
																			<td colspan="4" align="center">																		
																				<a href="#" id="add-item-link-${container?.id}">Add a new item</a>	
																			</td>
																		</tr>
																	    
																	    <!--  Temporarily removed the two forms until I can figure out a better way to integrate them -->
																	    <%-- 
																		<tr class="prop">
																			<td colspan="4">
																				<label><g:message code="shipment.contents.quickAdd.label" default="Quick Add" /></label></td>   
																				<div style="width:50%">
																					<g:form action="addItemAutoComplete" id="${shipmentInstance.id}">	
																						<gui:autoComplete size="20" width="100" id="selectedItem" name="selectedItem" controller="shipment" action="availableItems"/>											
																						<g:submitButton name="addItem" value="Add to shipment"/>
																					</g:form>			
																				</div>						
																			</td>
																		</tr>
																		<g:form action="addItem">
																			<g:hiddenField name="containerId" value="${container?.id}" />
																			<g:hiddenField name="shipmentId" value="${shipmentInstance?.id}" />
																			<tr>  
																				<td></td>
																				<td>
																					<g:textField name="quantity" size="5" /> units of 
																					<g:select 
																						id="productId" 
																						name='productId'
																					    noSelection="${['null':'Select One...']}"
																					    from='${Product.list()}' optionKey="id" optionValue="name">
																					</g:select>
																			    	<g:submitButton name="add" value="Add"/>
																			    </td>
																			    <td></td>
																			    <td></td>
																		    </tr>
																		</g:form>																    	
																		--%>					
																		
																    </g:else>
										                        </tbody>
															</table>   
														</td>
													</tr>											
												</tbody>
											</table>	
										</div>
										
										<script type="text/javascript">
											jQuery(document).ready(function($){
												$("a#show-container-contents-link-${container?.id}").click(function() {
													$("#container-contents-${container?.id}").toggle(0);													
												});										
												$('#copy-container-dialog-${container?.id}').dialog({
													autoOpen: false,
													width: 500
												});										
												$('#copy-container-link-${container?.id}').click(function(){
													$('#copy-container-dialog-${container?.id}').dialog('open');
													return false;
												});				
											});
											
										</script>													
										<br/>						
																
																
										<div id="copy-container-dialog-${container?.id}" title="Copy container" style="display: none;" >
											<g:form action="copyContainer">
												<g:hiddenField name="shipmentId" value="${shipmentInstance?.id}" />
												<g:hiddenField name="containerId" value="${container?.id}" />
												<table>
													<tbody>
														<tr class="prop">
								                            <td valign="top" class="name"><label><g:message code="container.name.label" default="Nickname" /></label></td>                            
								                            <td valign="top" class="value ${hasErrors(bean: containerInstance, field: 'name', 'errors')}">
																${container?.name}
							                                </td>
								                        </tr>  	          
														<tr class="prop">
								                            <td valign="top" class="name"><label><g:message code="container.name.label" default="Nickname" /></label></td>                            
								                            <td valign="top" class="value ${hasErrors(bean: containerInstance, field: 'name', 'errors')}">
																<g:textField name="name" value="${container?.name}" />
							                                </td>
								                        </tr>  	          
														<tr class="prop">
								                            <td valign="top" class="name"><label><g:message code="container.copies.label" default="# of Copies" /></label></td>                            
								                            <td valign="top" class="value ${hasErrors(bean: containerInstance, field: 'name', 'errors')}">
																<g:textField name="copies" value="1" />
							                                </td>
								                        </tr>  	          
								                        <tr>
														    <td colspan="2">
																<div class="buttons" style="text-align: right;">
																	<button type="submit" class="positive"><img src="${createLinkTo(dir:'images/icons/silk',file:'tick.png')}" alt="save" /> Add Piece</button>
																</div>
		
														    </td>					                        
								                        </tr>         
								                    </tbody>
								                </table>
										    </g:form>
										</div>								

										<%-- TODO:  SHOULD BE HIDDEN UNTIL USER REQUESTS TO ADD A NEW ITEM --%>														
										<div id="add-item-dialog-${container?.id}" style="display: none;" title="Add a new item">
											<g:form action="addItem">
												<g:hiddenField name="shipmentId" value="${shipmentInstance?.id}" />
												<g:hiddenField name="containerId" value="${container?.id}" />
												<table>
													<tbody>
														<tr>  
															<td valign="top" class="name"><label><g:message code="shipment.container.label" default="Adding to " /></label></td>                            
										                    <td valign="top" class="value ${hasErrors(bean: shipmentItem, field: 'container', 'errors')}">
										                    	${container?.name}
										                    <%--  
											                    <g:select id="container.id" name='container.id' noSelection="${['':'Select one ...']}"
											                     	from='${shipmentInstance.containers}' optionKey="id" optionValue="name"></g:select>
											                 --%>
															</td>
														</tr>
													
														<tr>  
															<td valign="top" class="name"><label><g:message code="shipmentItem.quantity.label" default="Quantity" /></label></td>                            
										                    <td valign="top" class="value ${hasErrors(bean: shipmentItem, field: 'quantity', 'errors')}">
																<g:textField name="quantity" size="5" /> 
															</td>
														</tr>
														<tr>
															<td valign="top" class="name"><label><g:message code="shipmentItem.quantity.label" default="Product" /></label></td>                            
										                    <td valign="top" class="value ${hasErrors(bean: shipmentItem, field: 'quantity', 'errors')}">												
																<g:select 
																	id="productId" 
																	name='productId'
																    noSelection="${['null':'Select One...']}"
																    from='${Product.list()}' optionKey="id" optionValue="name">
																</g:select>
														    </td>
														</tr>
														<tr>
															<td>
																<div class="buttons">
																	<button type="submit" class="positive"><img src="${createLinkTo(dir:'images/icons/silk',file:'tick.png')}" alt="save" /> Save</button>
																</div>
															</td>										
													    </tr>
												    </tbody>
											    </table>
											</g:form>
										</div>											
										<script type="text/javascript">
											jQuery(document).ready(function($){
												$('#add-item-dialog-${container?.id}').dialog({
													autoOpen: false,
													width: 500
												});										
												$('#add-item-link-${container?.id}').click(function(){
													$('#add-item-dialog-${container?.id}').dialog('open');
													return false;
												});				
											});
										</script>																			
									</g:each><!-- iterate over each container -->
									
									
									<%-- --%>
									<table style="background-color: white;">
										<tbody>
											<tr>
												<td valign="top">
													<div style="margin-top: 10px; margin-bottom: 10px;">
														<img src="${createLinkTo(dir:'images/icons',file:'box_24.gif')}" alt="box" /> <a href="#" id="add-container-link">Add a new piece</a>		
													</div>								
													<%-- 
													<div style="margin-top: 10px; margin-bottom: 10px;">
															<g:form action="addContainer">															
																<span style="font-size: 1.2em">
															 		(#<%= shipmentInstance.getContainers().size()+1 %>) 
																</span>
																Add a new <g:select 
																	id="containerTypeId" 
																	name='containerTypeId'
																    noSelection="${['null':'Select One...']}"
																    from='${ContainerType?.list()}' optionKey="id" optionValue="name">
																</g:select> 
																with name										
																<g:textField name="name" />
																and weighs
																<g:textField name="weight" /> kg
																<g:hiddenField name="shipmentId" value="${shipmentInstance?.id}" />
																
																
																
																<div class="buttons">
																	<button type="submit" class="positive"><img src="${createLinkTo(dir:'images/icons/silk',file:'tick.png')}" alt="save" /> Save</button>
																</div>
															</g:form>														
													</div>
													--%>
												</td>		
											</tr>
										</tbody>
									</table>
								</g:else>							
							</div>
							
						</gui:tab>
					    
					    <gui:tab id="shipmentDocumentsTab" label="Documents">				    
							<h2><g:message code="shipment.document.label" default="Documents" /></h2>
							<div id="documentsTab" class="tab">
								<g:if test="${!shipmentInstance.documents}">	
									<div class="notice">
										There are no documents for this shipment. &nbsp; &nbsp;
										<a href="#" id="add-document-link">Add a new document</a>									
									</div>
								</g:if>
								<g:else>
									<table>
										<thead>
				                       		<tr>
				                       			<th width="5%"></th>
				                       			<th>Document Type</th>
				                       			<th>Document</th>
				                       			<th>Size</th>
				                       			<th width="5%"></th>
				                       		</tr>
				                       	</thead>
				                       	<tbody>
										    <g:each in="${shipmentInstance.documents}" var="document" status="i">
												<tr id="document-${document.id}" class="${(i % 2) == 0 ? 'odd' : 'even'}">
													<td><img src="${createLinkTo(dir:'images/icons',file:'document.png')}" alt="Document" /></td>
													<td>${document?.documentType?.name}</td>
													<td>${document?.filename} (<g:link controller="document" action="download" id="${document.id}">download</g:link>)</td>
													<td>${document?.size} bytes</td>
													<td>
														<g:link class="remove" action="deleteDocument" id="${document?.id}">
															<img src="${createLinkTo(dir:'images/icons',file:'trash.png')}" alt="Delete Document"/>
														</g:link>
													</td>													
												</tr>
										    </g:each>
										    <tr>
										    	<td><img src="${createLinkTo(dir:'images/icons',file:'document.png')}" alt="Document" /></td>
										    	<td colspan="4">
										    		<a href="#" id="add-document-link">Add a new document</a>
										    	
										    	</td>
										    
										    </tr>
										    <%-- 
											<g:uploadForm controller="document" action="upload">
												<g:hiddenField name="shipmentId" value="${shipmentInstance?.id}" />
												<tr>
													<td></td>
													<td>	
														<g:select name="type" from="${Document.constraints.type.inList}" valueMessagePrefix="document.type"  />							    
													</td>																								
													<td>
														<input name="contents" type="file" />
														<g:submitButton name="upload" value="Upload"/>
													</td>
												</tr>
										    </g:uploadForm>
										    --%>											    
										</tbody>
					                </table>
								</g:else>
							</div>
					    </gui:tab>
					    <gui:tab id="shipmentCommentsTab" label="Comments">				
					    	    
					    	<h2><g:message code="shipment.comments.label" default="Comments" /></h2>
					    
						    <div id="commentsTab" class="tab">	
						    	<g:if test="${!shipmentInstance?.comments}">
									<div class="notice">
										There are no comments for this shipment. &nbsp; &nbsp;
										<a href="#" id="add-comment-link">Add a new comment</a>									
									</div>
						    	</g:if>
						    	<g:else>
						    		

									<table>
										<thead>
				                       		<tr>
				                       			<th width="5%"></th>
				                       			<th>From</th>
				                       			<th>To</th>
				                       			<th>Comment</th>
				                       			<th></th>
				                       		</tr>
				                       	</thead>
				                       	<tbody>
										    <g:each in="${shipmentInstance.comments}" var="comment" status="i">
												<tr id="comment-${comment.id}" class="${(i % 2) == 0 ? 'odd' : 'even'}">
													<td><img src="${createLinkTo(dir:'images/icons',file:'tag.png')}" alt="Comment" /></td>
													<td>${comment?.commenter}</td>
													<td>${comment?.recipient} </td>
													<td>${comment?.comment}</td>
													<td>
														<g:link action="deleteComment" id="${comment?.id}">
															<img src="${createLinkTo(dir:'images/icons',file:'trash.png')}" alt="Delete Comment"/>
														</g:link>
													</td>													
													
													
												</tr>
										    </g:each>
										    <tr>
										    	<td><img src="${createLinkTo(dir:'images/icons',file:'tag.png')}" alt="Comment" /></td>
										    	<td colspan="4">
										    		<a href="#" id="add-comment-link">Add a new comment</a>
										    	</td>
										    
										    </tr>
										    <%-- 
											<g:uploadForm controller="document" action="upload">
												<g:hiddenField name="shipmentId" value="${shipmentInstance?.id}" />
												<tr>
													<td></td>
													<td>	
														<g:select name="type" from="${Document.constraints.type.inList}" valueMessagePrefix="document.type"  />							    
													</td>																								
													<td>
														<input name="contents" type="file" />
														<g:submitButton name="upload" value="Upload"/>
													</td>
												</tr>
										    </g:uploadForm>
										    --%>											    
										</tbody>
					                </table>


						    	</g:else>
						    	
						        <%-- 
						        
						        
						        <g:editInPlace id="comments-${shipmentInstance.id}" 
						        	paramName="comments" 
						        	url="[action:'updateComments', id:shipmentInstance.id]" 
						        	rows="5" cols="10">${shipmentInstance?.comments}</g:editInPlace>
						        --%>
							</div>
					    </gui:tab>					    				    
					    <gui:tab id="shipmentTestTab" label="Test">
				            <div id="testTab" class="tab">


				            	<!-- All hidden DIVs have been temporarily place into the 'test' tab in case the jquery-ui libraries fail to load  -->
								<div id="add-container-dialog" title="Add a new piece">
									<g:form action="addContainer">
										<g:hiddenField name="shipmentId" value="${shipmentInstance?.id}" />
										<table>
											<tbody>
												<tr class="prop">
						                            <td valign="top" class="name"><label><g:message code="container.containerType.label" default="Container Type" /></label></td>                            
						                            <td valign="top" class="value ${hasErrors(bean: containerInstance, field: 'containerType', 'errors')}">
					                                    <g:select 
															id="containerTypeId" 
															name='containerTypeId'
														    noSelection="${['null':'Select One...']}"
														    from='${ContainerType?.list()}' optionKey="id" optionValue="name">
														</g:select>
					                                </td>
						                        </tr>  	          
												<tr class="prop">
						                            <td valign="top" class="name"><label><g:message code="container.name.label" default="Nickname" /></label></td>                            
						                            <td valign="top" class="value ${hasErrors(bean: containerInstance, field: 'name', 'errors')}">
														<g:textField name="name" />
					                                </td>
						                        </tr>  	          
						                        <tr>
												    <td colspan="2">
														<div class="buttons" style="text-align: right;">
															<button type="submit" class="positive"><img src="${createLinkTo(dir:'images/icons/silk',file:'tick.png')}" alt="save" /> Add Piece</button>
														</div>

												    </td>					                        
						                        </tr>         
						                    </tbody>
						                </table>
								    </g:form>
								</div>								
								
								
								<div id="add-event-dialog" title="Add a new event">
									<g:form action="addEvent">
										<g:hiddenField name="shipmentId" value="${shipmentInstance?.id}" />
										<table>
											<tbody>
												<tr class="prop">
						                            <td valign="top" class="name"><label><g:message code="event.eventDate.label" default="Event Date" /></label></td>                            
						                            <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'eventDate', 'errors')}">
					                                    <g:datePicker id="eventDate" name="eventDate" value="" />
					                                </td>
						                        </tr>  	          
												<tr class="prop">
						                            <td valign="top" class="name"><label><g:message code="event.eventType.label" default="Event Type" /></label></td>                            
						                            <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'eventDate', 'errors')}">
					                                    <g:select id="eventTypeId" name='eventTypeId' noSelection="${['':'Select one ...']}" 
					                                    	from='${EventType.list()}' optionKey="id" optionValue="name"></g:select>
					                                </td>
						                        </tr>  	          
												<tr class="prop">
						                            <td valign="top" class="name"><label><g:message code="event.eventDate.label" default="Location" /></label></td>                            
						                            <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'location', 'errors')}">
														<g:select id="eventLocationId" name='eventLocationId' noSelection="${['':'Select one ...']}" 
															from='${Location.list()}' optionKey="id" optionValue="name">
															</g:select>									
					                                </td>
						                        </tr>  	          
											<%-- 
												<tr class="prop">
						                            <td valign="top" class="name"><label><g:message code="event.eventDate.label" default="Event Date" /></label></td>                            
						                            <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'eventDate', 'errors')}">
														<g:select id="targetLocationId" name='targetLocationId' noSelection="${['':'Select one ...']}" 
															from='${Location.list()}' optionKey="id" optionValue="name"></g:select>									
					                                </td>
						                        </tr>  	          
												<tr class="prop">
						                            <td valign="top" class="name"><label><g:message code="event.description.label" default="Comment" /></label></td>                            
						                            <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'description', 'errors')}">
														<g:textField name="description" size="15" /> 
					                                </td>
						                        </tr>  	 
										    --%>
						                        <tr>
												    <td colspan="2">
														<div class="buttons" style="text-align: right;">
															<button type="submit" class="positive"><img src="${createLinkTo(dir:'images/icons/silk',file:'tick.png')}" alt="save" /> Add Event</button>
														</div>
												    </td>					                        
						                        </tr>         
						                    </tbody>
						                </table>
								    </g:form>
								</div>
										
								<div id="add-document-dialog" title="Add a new document">
									<g:uploadForm controller="document" action="upload">
										<g:hiddenField name="shipmentId" value="${shipmentInstance?.id}" />
										<table>
											<tbody>
												<tr class="prop">
						                            <td valign="top" class="name"><label><g:message code="document.documentType.label" default="Document Type" /></label></td>                            
						                            <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'documentType', 'errors')}">																
														<g:select name="type" from="${DocumentType.list()}" valueMessagePrefix="document.type"  />							    												
													</td>
												</tr>
												<tr>
													<td valign="top" class="name"><label><g:message code="document.file.label" default="Select a file" /></label></td>                            
						                            <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'contents', 'errors')}">																
														<input name="contents" type="file" />												
													</td>
												</tr>
												<tr>
													<td valign="top" colspan="2">														
														<div class="buttons" style="text-align: right;">
															<button type="submit" class="positive"><img src="${createLinkTo(dir:'images/icons/silk',file:'tick.png')}" alt="save" /> Upload Document</button>
														</div>														
													</td>
												</tr>
											</tbody>
						                </table>
								    </g:uploadForm>													
								</div>										
												
								<div id="add-comment-dialog" title="Add a new comment">
									<g:form action="addComment">
										<g:hiddenField name="shipmentId" value="${shipmentInstance?.id}" />
										<table>
											<tbody>
												<tr class="prop">
						                            <td valign="top" class="name"><label><g:message code="comment.commenter.label" default="From" /></label></td>                            
						                            <td valign="top" class="value ${hasErrors(bean: commentInstance, field: 'commenter', 'errors')}">
					                                    ${session.user.username}
					                                </td>
						                        </tr>  	          
												<tr class="prop">
						                            <td valign="top" class="name"><label><g:message code="comment.recipient.label" default="To" /></label></td>                            
						                            <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'recipient', 'errors')}">
														<g:select id="recipientId" name='recipientId' noSelection="${['':'Select one ...']}" 
					                                    	from='${User.list()}' optionKey="id" optionValue="username"></g:select>
					                                </td>
						                        </tr>  	          
												<tr class="prop">
						                            <td valign="top" class="name"><label><g:message code="comment.comment.label" default="Comment" /></label></td>                            
						                            <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'comment', 'errors')}">
					                                    <g:textArea name="comment" size="15" />
					                                    <%-- <gui:richEditor id='editor' value=""/>--%>
					                                    
					                                </td>
						                        </tr>  	        
						                        <tr>
													<td valign="top" colspan="2" style="text-align: right">
														<g:submitButton name="add" value="Add Comment"/>
													</td>
												</tr>
						                        
						                          
											</tbody>
										</table>
									</g:form>												
								</div>										
							</div>
						</gui:tab>
					    
					    
					</gui:tabView>
	            </div>	
	    	</div>			
	    	
	    	
	    	<%-- 
			<div class="buttons" align="left">
				<g:form>
					<g:hiddenField name="id" value="${shipmentInstance?.id}" />
					<span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
					<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
				</g:form>
			</div>	
			--%>
        </div>
        
		<script type="text/javascript">
			jQuery(document).ready(function($){
				$('a#edit-details-link').click(function() { 
					$('#view-details').toggle(0);
					$('#edit-details').toggle(0);
				});
				$('a#edit-origin-link').click(function() { 
					$('#view-origin').toggle(0);
					$('#edit-origin').toggle(0);
				});
				$('a#edit-destination-link').click(function() { 
					$('#view-destination').toggle(0);
					$('#edit-destination').toggle(0);
				});								
		
				/* add an event to a shipment */
				$('#add-event-dialog').dialog({ autoOpen: false, width: 500 });				
				$('#add-event-link').click(function(){
					$('#add-event-dialog').dialog('open');
					return false;
				});				
		
				/* add a container to a shipment */
				$('#add-container-dialog').dialog({ autoOpen: false, width: 500 });										
				$('#add-container-link').click(function(){
					$('#add-container-dialog').dialog('open');
					return false;
				});						
		
				/* add a document to a shipment */
				$('#add-document-dialog').dialog({ autoOpen: false, width: 500 });										
				$('#add-document-link').click(function(){
					$('#add-document-dialog').dialog('open');
					return false;
				});						
		
				/* add an event to a shipment */
				$('#add-comment-dialog').dialog({ autoOpen: false, width: 800 });				
				$('#add-comment-link').click(function(){
					$('#add-comment-dialog').dialog('open');
					return false;
				});				
			});
		</script>				            
        
        
    </body>
</html>


           <%-- 
            <div class="dialog">
    		    <h1>AJAX Testing</h1>
				<h1>Add Product to Shipment (g:submitToRemote):</h1>            
			    <g:form action="addProductToShipmentAjax">
				 
					<g:hiddenField name="shipmentId" value="${shipmentInstance?.id}" />
					<input name="trackingNumber" type="text"></input>
					<g:submitToRemote update="updateMe" 
						  value="Add"
						  url="[controller: 'shipment', action: 'addShipmentAjax']"/>
			    </g:form>

				<h1>Add Product to Shipment (g:remoteForm):</h1>
				<g:remoteForm action="addProductToShipmentAjax">
					<g:hiddenField name="shipmentId" value="${shipmentInstance?.id}" />
					<g:textField name="quantity" size="5" /> x 
					<g:select 
						id="productId" 
						name='productId'
					    noSelection="${['null':'Select One...']}"
					    from='${Product.list()}' optionKey="id" optionValue="name">
					</g:select>
					<g:submitButton name="add" value="Add"/>
			    </g:remoteForm>

			    <div id="updateMe">this div is updated by the form</div>
			    
			    Quick add:
			    <g:form action="ajaxAdd">
				   <g:textArea id='shipmentContent' name="content" rows="3" cols="50"/><br/>
				   <g:submitToRemote 
				       value="Add shipment"
				       url="[controller: 'shipment', action: 'addShipmentAjax']"
				       update="allShipments"
				       onSuccess="clearShipment(e)"
				       onLoading="showSpinner(true)"
				       onComplete="showSpinner(false)"/>
				   <img id="spinner" style="display: none" src="<g:createLinkTo dir='/images' file='spinner.gif'/>"/>
			    </g:form>
            </div>
		--%>
