package org.pih.warehouse

import java.io.File;

import org.pih.warehouse.Comment;
import org.pih.warehouse.Event;
import org.pih.warehouse.ShipmentEvent;
import grails.converters.JSON;

class ShipmentController {
   
    def scaffold = Shipment
    def shipmentService
    
    
    // Wed Jun 23 00:00:00 CDT 2010
    // yyyy-MM-dd HH:mm:ss z
    
    def list = { 
    	def browseBy = params.id;
    	def currentLocation = Location.get(session.warehouse.id);
    	
    	println ("current location" + currentLocation.name)
    	
    	def allShipments = shipmentService.getShipmentsWithAnyLocation(currentLocation);
		def incomingShipments = shipmentService.getShipmentsWithDestination(currentLocation);	
		def outgoingShipments = shipmentService.getShipmentsWithOrigin(currentLocation);	
		
		def shipmentInstanceList = ("incoming".equals(browseBy)) ? incomingShipments : 
			("outgoing".equals(browseBy)) ? outgoingShipments : allShipments;
		
		[shipmentInstanceList: shipmentInstanceList,
		 shipmentInstanceTotal: allShipments.size(),
		 incomingShipmentCount: incomingShipments.size(),
		 outgoingShipmentCount: outgoingShipments.size()]
    }
    
        
    
    def addShipmentAjax = {
		try {
		    //def newPost = postService.createPost(session.user.userId, params.content);
		    //def recentShipments = Shipment.findAllBy(session.user, [sort: 'id', order: 'desc', max: 20])
		    //render(template:"list", collection: recentShipments, var: 'shipment')
		    render { div(class:"errors", "success message") }
		} catch (Exception e) {
		    render { div(class:"errors", e.message) }
		}
    }
    
    def availableItems = {     		
    	println params;
    	def items = null;
    	if (params.query) { 
	    	items = Product.findAllByNameLike("%${params.query}%");
	    	items = items.collect() {
	    		[id:it.id, name:it.name]
	    	}
    	}
    	def jsonItems = [result: items]    	
    	render jsonItems as JSON;    		
    }
    
    def addItemAutoComplete = {     		
    	println params;
    	
    	def product = Product.get(params.selectedItem_id)
    	def shipment = Shipment.get(params.id);

    	println "containers: " + shipment.getContainers()
    	    	
    	def container = shipment.containers[0];
    	if (container) { 
 	    	def shipmentItem = new ShipmentItem(product: product, quantity: 1);
	    	container.addToShipmentItems(shipmentItem).save(flush:true);
    	}
    	redirect action: "show", id: shipment.id;
    }    
    
    
    def addContainer = { 
    	def shipment = Shipment.get(params.shipmentId);   	
    	def containerType = ContainerType.get(params.containerTypeId);    	
    	def name = (params.name) ? params.name : containerType.name + " " + shipment.getContainers().size()
        def container = new Container(name: name, weight: params.weight, units: params.units, containerType: containerType);
        shipment.addToContainers(container);
        flash.message = "Added a new piece to the shipment";		
		redirect(action: 'show', id: params.shipmentId)    
    }
    
    def copyContainer = { 
        	def shipment = Shipment.get(params.shipmentId);   	
        	def container = Container.get(params.containerId);  
        	def name = (params.name) ? params.name : "New Package";
        	def copies = params.copies
        	def x = Integer.parseInt(copies)
        	int index = 1;
        	while ( x-- > 0 ) {
        		def containerCopy = new Container(container.properties);
        		containerCopy.id = null;
        		containerCopy.name = name + " " + (index++);
        		containerCopy.containerType = container.containerType;
        		containerCopy.weight = container.weight;
        		containerCopy.shipmentItems = null;
        		containerCopy.save(flush:true);
        		
        		container.shipmentItems.each { 
        			def shipmentItemCopy = new ShipmentItem();
        			shipmentItemCopy.product = it.product
        			shipmentItemCopy.quantity = it.quantity;
        			containerCopy.addToShipmentItems(shipmentItemCopy).save(flush:true);
        		}
        		
        		shipment.addToContainers(containerCopy).save(flush:true);
        	}
    		flash.message = "Copied package multiple times within the shipment";		
    		redirect(action: 'show', id: params.shipmentId)        		
        }    
    
    
    def deleteContainer = { 
    		
		def container = Container.get(params.id);
    	def shipmentId = container.getShipment().getId();
    	
    	if (container.getShipmentItems().size() > 0) {
    		flash.message = "Cannot delete a container that is not empty";
    		redirect(action: 'show', id: shipmentId);    		
    	}
    	else { 
    		container.delete();	    	    	
    		redirect(action: 'show', id: shipmentId)     		
    	}    		
    }
    
    
    def addComment = { 
    	println params;
    	def shipment = (params.shipmentId) ? Shipment.get(params.shipmentId) : null;    	
    	def recipient = (params.recipientId) ? User.get(params.recipientId) : null;
    	def comment = new Comment(comment: params.comment, commenter: session.user, recipient: recipient)
    	if (shipment) { 
	    	shipment.addToComments(comment).save();
	    	flash.message = "Added comment '${params.comment}'to shipment $shipment.id";		
    	}
		redirect(action: 'show', id: params.shipmentId)    	    		
    }
    
    def deleteComment = { 
        	def comment = Comment.get(params.id);
       		def shipmentId = comment.getShipment().getId();    	
        	if (comment) { 	    	
           	    comment.delete();	    	    	
            	flash.message = "Deleted comment $comment from shipment $shipment.id";		
    	    	redirect(action: 'show', id: shipmentId) 
        	}
        	else { 
            	flash.message = "Could not remove comment $params.id from shipment";		
        		redirect(action: 'show', id: shipmentId)    	
        		
        	}
        }
    
    

    def addItem = {     		
    	println params;
    		
    	def container = Container.get(params.containerId);
    	def product = Product.get(params.productId);
    	def quantity = params.quantity;
    	// if container already includes a shipment item with this product, 
    	// we just need to add to the total quantity
    	
    	def shipmentItem = new ShipmentItem(product: product, quantity: quantity);    	
    	container.addToShipmentItems(shipmentItem).save(flush:true);
    	flash.message = "Added $params.quantity units of $product.name";		
		redirect(action: 'show', id: params.shipmentId)    	
    	
    }
    

    def deleteItem = { 
    	def item = ShipmentItem.get(params.id);
		def container = item.getContainer();
		def shipmentId = container.getShipment().getId();    	
    	if (item) { 	    	
	    	item.delete();	    	    	
        	flash.message = "Deleted shipment item $params.id from container $container.name";		
	    	redirect(action: 'show', id: shipmentId) 
    	}
    	else { 
        	flash.message = "Could not remove item $params.id from container";		
    		redirect(action: 'show', id: shipmentId)    	
    		
    	}
    }

    
    def deleteDocument = { 
    	def document = Document.get(params.id);
   		def shipmentId = document.getShipment().getId();    	
    	if (document) { 	    	
       	    document.delete();	    	    	
        	flash.message = "Deleted document $params.id from shipment";		
	    	redirect(action: 'show', id: shipmentId) 
    	}
    	else { 
        	flash.message = "Could not remove document $params.id from shipment";		
    		redirect(action: 'show', id: shipmentId)    	
    		
    	}
    }
    
    
    def addEvent = { 
    		
    	def targetLocation = null    	
    	if (params.targetLocationId) { 
        	Location.get(params.targetLocationId)
    	}
    	
    	ShipmentEvent event = new ShipmentEvent(
    		eventType:EventType.get(params.eventTypeId), 
    		eventDate: params.eventDate, 
    		eventLocation: Location.get(params.eventLocationId),
    		targetLocation: targetLocation
    	);
    	
    	def shipment = Shipment.get(params.shipmentId);     	
    	shipment.addToEvents(event).save(flush:true);    

    	flash.message = "Added event";		
		redirect(action: 'show', id: params.shipmentId)    	
	}    

    def deleteEvent = { 
    	def event = Event.get(params.id);
    	def shipmentId = event.getShipment().getId();    	
    	event.delete();	    	    	
    	redirect(action: 'show', id: shipmentId) 
    }
    
    
    def form = {
        [ shipments : Shipment.list() ]
    }
    
    def view = {
    	// pass through to "view shipment" page
    }
}

