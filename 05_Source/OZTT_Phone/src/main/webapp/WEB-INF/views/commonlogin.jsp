
<!-- BEGIN fast view of a product -->
<div id="login-pop-up" style="display: none; width: 500px;height:300px">
	<div class="login-page login-pop-up">
		<div>
			<div style="text-align: center">
			<h1 >
				<fmt:message key="OZ_TT_TP_LG_h1" />
			</h1>
			</div>
			<div class="content-form-page">
				<div class="row">
					<div class="col-md-12 col-sm-12">
						<div class="form-group" style="padding-top: 15px;">
							<label for="username" class="col-lg-4 control-label"><fmt:message
									key="OZ_TT_TP_LG_email" /> <span class="require">*</span> </label>
							<div class="col-lg-7">
								<input type="text" class="form-control" id="username" />
							</div>
						</div>
						<div class="form-group" style="padding-top: 30px;">
							<label for="password" class="col-lg-4 control-label"><fmt:message
									key="OZ_TT_TP_LG_password" /> <span class="require">*</span> </label>
							<div class="col-lg-7">
								<input type="password" class="form-control" id="password" />
							</div>
						</div>
						<div class="row" style="padding-top: 30px;">
							<div class="col-lg-8 col-md-offset-4 padding-left-0">
								<a onclick="toForgetPw()"><fmt:message key="OZ_TT_TP_LG_fp" /></a>
							</div>
						</div>
						<div class="row">
							<div
								class="col-lg-8 col-md-offset-4 padding-left-0 padding-top-20">
								<button type="button" class="btn btn-primary" onclick="checkLogin()">
									<fmt:message key="OZ_TT_TP_LG_btlogin" />
								</button>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>