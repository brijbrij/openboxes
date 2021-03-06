<tr>
    <td class="middle">
    </td>
    <td class="middle">
        <g:autoSuggest id="product" name="product"
                       jsonUrl="${request.contextPath }/json/findProductByName?skipQuantity=true&supplierId=${order?.originParty?.id}"
                       styleClass="text large required"/>
    </td>
    <td class="middle center">
        <select id="productSupplier" name="productSupplier.id"></select>
    </td>
    <td class="middle center">
        <div id="supplierCode"></div>
    </td>
    <td class="middle center">
        <div id="manufacturer"></div>
    </td>
    <td class="middle center">
        <div id="manufacturerCode"></div>
    </td>
    <td class="middle center">
        <input type="number" id="quantity" name="quantity" class="text" placeholder="Quantity" style="width: 100px"/>
    </td>
    <td class="center middle">
        <g:selectUnitOfMeasure id="quantityUom"
                               name="quantityUom.id" class="select2 required" style="width: 120px"
                               noSelection="['':'']"/>
    </td>
    <td class="center middle">
        <input type="number" id="quantityPerUom" name="quantityPerUom" class="text required" placeholder="Qty per UoM" style="width: 100px"/>
    </td>
    <td class="center middle">
        <input type="number" id="unitPrice" required name="unitPrice" size="2" class="text required" placeholder="Price per UoM" style="width: 100px"/>
    </td>
    <td class="center middle">
    </td>
    <td class="center middle">
        <g:hiddenField id="defaultRecipient" name="defaultRecipient" value="${order?.orderedBy?.id}"/>
        <g:selectPerson id="recipient" name="recipient" value="${order?.orderedBy?.id}"
                        noSelection="['':'']" class="chzn-select-deselect"/>
    </td>
    <td class="center middle">
        <g:jqueryDatePicker id="estimatedReadyDate" name="estimatedReadyDate" value="" placeholder="Expected ready date"
                            autocomplete="off" noSelection="['':'']"/>
    </td>
    <td class="center middle">
        <button id="save-item-button" class="button save-item">
            <img src="${resource(dir: 'images/icons/silk', file: 'tick.png')}" />&nbsp;
            <warehouse:message code="default.button.save.label"/>
        </button>
    </td>
</tr>
