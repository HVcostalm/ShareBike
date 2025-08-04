<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Teste Cadastro Usuário</title>
</head>
<body>
<h2>Formulário de Cadastro de Usuário</h2>
    <form action="UsuarioController" method="post">
        <input type="hidden" name="action" value="adicionar" />
        
        <label for="cpfCnpj">CPF/CNPJ:</label><br/>
        <input type="text" id="cpfCnpj" name="cpfCnpj" required /><br/><br/>
        
        <label for="nomeRazaoSocial">Nome/Razão Social:</label><br/>
        <input type="text" id="nomeRazaoSocial" name="nomeRazaoSocial" required /><br/><br/>
        
        <label for="foto">Foto (URL):</label><br/>
        <input type="text" id="foto" name="foto" /><br/><br/>
        
        <label for="cidade">Cidade:</label><br/>
        <input type="text" id="cidade" name="cidade" /><br/><br/>
        
        <label for="estado">Estado:</label><br/>
        <input type="text" id="estado" name="estado" /><br/><br/>
        
        <label for="pais">País:</label><br/>
        <input type="text" id="pais" name="pais" /><br/><br/>
        
        <label for="telefone">Telefone:</label><br/>
        <input type="text" id="telefone" name="telefone" /><br/><br/>
        
        <label for="email">Email:</label><br/>
        <input type="email" id="email" name="email" required /><br/><br/>
        
        <label for="senha">Senha:</label><br/>
        <input type="password" id="senha" name="senha" required /><br/><br/>
        
        <label for="fotoComprBike">Comprovação Bike (URL):</label><br/>
        <input type="text" id="fotoComprBike" name="fotoComprBike" /><br/><br/>
        
        <button type="submit">Cadastrar Usuário</button>
    </form>
</body>
</html>