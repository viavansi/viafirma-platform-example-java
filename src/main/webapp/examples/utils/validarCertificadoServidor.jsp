<%@page import="org.viafirma.client.vo.validation.ValidationInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<title>Viafirma - Kit para desarrolladores</title>
		
		<link rel="stylesheet" href="../../css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="../../css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href="../../"><img src="../../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<h2>Comprobación de validez de certificador en el servidor</h2>
				
				<div class="group">
					<div class="col width-58 append-02">
						<div class="box">
							<h3 class="box-title">Verificar que el certificado sea válido</h3>
							
							<div class="box-content">
								<p>En este ejemplo se realiza la comprobación de un certificado si es válido, está caducado o revocado. Este certificado se encuentra alojado en el caert del servidor.</p>
								<form action="?validateCert">
									<p>
										Alias del certificado:    
										<input style="width: 100%"type="text" value="" name="aliasCert">
									</p>
									<input type="submit" class="enlaceFakeButton" value="Verificar certificado">
								</form>
							</div>
						</div>
								<%
								if(request.getParameter("aliasCert")!=null){
							
									if (!ViafirmaClientFactory.isInit()){
										ViafirmaClientFactory.init(
												ConfigureUtil.getViafirmaServer(),
												ConfigureUtil.getViafirmaServerWS(),
												ConfigureUtil.getApiKey(),
												ConfigureUtil.getApiPass());
									}
									ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
									String alias= (String)request.getParameter("aliasCert");
									//Ejecutamos el método de validación y obtenemos la información de la misma
									try{
									ValidationInfo validationInfo = viafirmaClient.checkCertificateByAlias(alias);
									%>
									<div class="box">
										<h2 class="box-title">Ejemplo</h2> 
										<div class="box-content">
											<p><%=validationInfo.getCertificate().getSubject()%><br/></p>
											<p><strong>Type Legal: </strong><%=validationInfo.getCertificate().getPropertiesOID().get("typeLegal")%><br/></p>
											<p><strong>¿Es válido?: </strong><%=validationInfo.getValidationResponse().isValidated()%><br/></p>
											<p><strong>¿Caducado?: </strong><%=validationInfo.getValidationResponse().isExpired()%><br/></p>
											<p><strong>¿Revocado?: </strong><%=validationInfo.getValidationResponse().getRevocationDate()!=null ? true: false%><br/></p>
										</div>
									</div>
								<%
									}catch(Exception e){
								%>
									   <p><%=e.getMessage() %></p>
								<%
									}
								}
								%>
					</div>
					
					<div class="col width-40">
						<div class="box">
							<h3 class="box-title">Metodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li>checkCertificateByAlias</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<p><a href="../../index.jsp">&larr; Volver</a></p>
			</div>
			<div id="footer">
				<p class="left">
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="https://doc.viafirma.com/viafirma-platform/integration/">Manual de integración de viafirma platform</a> 
				</p>
				<p>
					<small>3.0.0</small>
				</p>
			</div>
		</div>
	</body>
</html>