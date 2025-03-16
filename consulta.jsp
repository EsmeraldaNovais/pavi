<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PAVI</title>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 17px;
            background-image: url('imagem/fundo2.jpg');
            background-size: cover;
            background-position: center;
        }

        a {
            text-decoration: none;
            font-family: Arial, Helvetica, sans-serif;
        }

        .container {
            width: 80%;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            color: #aa1945;
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        .search-form input[type="text"] {
            width: 30%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .search-form button {
            padding: 10px 20px;
            background-color: #aa1945;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .search-form button:hover {
            background-color: #f5e269;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #aa1945;
            color: white;
            font-size: 1.2rem;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

        .button {
            display: inline-block;
            background-color: #aa1945;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin: 20px 0;
        }

        .button:hover {
            background-color: #f5e269;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Consulta de Voluntaios</h2>

        <form method="get" class="search-form">
            <input type="text" name="search" placeholder="Pesquise por nome..." value="<%= request.getParameter("search") %>">
            <button type="submit">Pesquisar</button>
        </form>

        <%
            String search = request.getParameter("search");  // Pega o valor da pesquisa, se houver
            String driver = "com.mysql.jdbc.Driver"; // para versões antigas do MySQL
            String url = "jdbc:mysql://localhost:3306/paviweb"; // URL de conexão com o banco de dados
            String usuario = "root"; // Usuário do banco de dados
            String senha = ""; // Senha do banco de dados

            Connection conexao = null;
            PreparedStatement stmt = null;  // Corrigido para PreparedStatement
            ResultSet rs = null;
            
            try {
                // Carregar o driver JDBC
                Class.forName(driver);
                
                // Estabelecer a conexão com o banco de dados
                conexao = DriverManager.getConnection(url, usuario, senha);
                
                // Criar a consulta SQL com o filtro de pesquisa (se houver)
                String sql = "SELECT * FROM voluntarios";
                if (search != null && !search.isEmpty()) {
                    sql += " WHERE nome LIKE ?";
                }
                
                // Criar o preparedStatement e executar a consulta
                stmt = conexao.prepareStatement(sql);
                if (search != null && !search.isEmpty()) {
                    stmt.setString(1, "%" + search + "%");  // Realiza a busca por nome
                }
                
                rs = stmt.executeQuery();
                
                out.println("<table>");
                out.println("<tr><th>Código</th><th>Nome</th><th>Email</th><th>Telefone</th><th>Ajuda</th></tr>");
                
                // Loop para exibir os dados
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("codigo") + "</td>");
                    out.println("<td>" + rs.getString("nome") + "</td>");
                    out.println("<td>" + rs.getString("email") + "</td>");
                    out.println("<td>" + rs.getString("telefone") + "</td>");
                    out.println("<td>" + rs.getString("ajuda") + "</td>");
                    out.println("</tr>");
                }
                
                out.println("</table>");
                
            } catch (ClassNotFoundException e) {
                out.println("<h3>Erro ao carregar o driver JDBC: " + e.getMessage() + "</h3>");
            } catch (SQLException e) {
                out.println("<h3>Erro ao consultar o banco de dados: " + e.getMessage() + "</h3>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conexao != null) conexao.close();
                } catch (SQLException e) {
                    out.println("<h3>Erro ao fechar recursos: " + e.getMessage() + "</h3>");
                }
            }
        %>

        <a href="quemsomos.html" class="button">Voltar</a>
    </div>
</body>
</html>
