
<!-- BEGIN fast view of a product -->
<div id="address-pop-up" style="display: none; width: 700px;height:450px">
	<div class="address-page address-pop-up">
		<div>
			<div style="text-align: center">
			<h1 id="h1Msg">
				
			</h1>
			</div>
			<div class="content-form-page">
				<div class="row">
					<div class="col-md-12 col-sm-12">
					
						<div class="form-group col-sm-12">
							<label for="details" class="col-lg-2 control-label" style="margin-top:5px;text-align:right">
								<fmt:message key="common_address_details" /> <span class="require">*</span> 
							</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" id="details" maxlength="200"/>
							</div>
						</div>
						
						<div class="form-group col-sm-12">
							
							<label for="suburb" class="col-lg-2 control-label" style="margin-top:5px;text-align:right">
								<fmt:message key="common_address_suburb" /> <span class="require">*</span> 
							</label>
							<div class="col-lg-4">
								<select  class="form-control"  id="suburb" onchange="showYunfei()">
									<option value=""></option>
	                    			<c:forEach var="seList" items="${ suburbSelect }">
	                    				<option value="${ seList.key }">${ seList.value }</option>
	                    			</c:forEach>
                    			</select>
                    			
                    			
								
							</div>
							<div class="col-lg-2 textleft" style="margin-top:5px"><span id="yunfeiSpan"></span></div>
							<div class="col-lg-4"></div>
						</div>
						
						<div class="form-group col-sm-12">
							<label for="state" class="col-lg-2 control-label" style="margin-top:5px;text-align:right">
								<fmt:message key="common_address_state" /> <span class="require">*</span> 
							</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" id="state" maxlength="50"/>
							</div>
							
							<label for="country" class="col-lg-2 control-label" style="margin-top:5px;text-align:right">
								<fmt:message key="common_address_country" /> <span class="require">*</span> 
							</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" id="country" maxlength="20" disabled="disabled" value="<fmt:message key="common_defaultCountry" />"/>
							</div>
							
						</div>
						
						
						
						
						
						
						<div class="form-group col-sm-12">
							<label for="post" class="col-lg-2 control-label" style="margin-top:5px;text-align:right">
								<fmt:message key="common_address_post" /> <span class="require">*</span> 
							</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" id="post" maxlength="20"/>
							</div>
							<div class="col-lg-6">
							</div>
						</div>
						
						<div class="form-group col-sm-12">
							<label for="reveiver" class="col-lg-2 control-label" style="margin-top:5px;text-align:right">
								<fmt:message key="common_address_reveiver" /> <span class="require">*</span> 
							</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" id="reveiver" maxlength="50"/>
							</div>
							
							<label for="contacttel" class="col-lg-2 control-label" style="margin-top:5px;text-align:right">
								<fmt:message key="common_address_contacttel" /> <span class="require">*</span> 
							</label>
							<div class="col-lg-4">
								<input type="text" class="form-control" id="contacttel" maxlength="20"/>
							</div>
						</div>
						

						<div class="row">
							<div
								class="col-lg-8 col-md-offset-4 padding-left-0 padding-top-20">
								<button type="button" class="btn btn-primary" onclick="submitAddress()">
									<fmt:message key="common_address_btnsubmit" />
								</button>
							</div>
							<input type="hidden" value="" id="hiddenAddressId" />
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>