<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ with secret "secret/data/nginx/site" }}{{ .Data.data.title }}{{ end }}</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            color: #333;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        header {
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        h1 {
            color: #2c3e50;
        }
        .info {
            background-color: #e7f3fe;
            border-left: 6px solid #2196F3;
            padding: 10px 15px;
            margin: 15px 0;
        }
        footer {
            text-align: center;
            margin-top: 20px;
            font-size: 0.8em;
            color: #777;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>{{ with secret "secret/data/nginx/site" }}{{ .Data.data.header }}{{ end }}</h1>
        </header>
        
        <main>
            <div class="info">
                <p>Эта страница защищена с использованием Vault для управления секретами.</p>
            </div>
            
            <section>
                <h2>Информация о сервере</h2>
                <p>{{ with secret "secret/data/nginx/site" }}{{ .Data.data.server_info }}{{ end }}</p>
            </section>
            
            <section>
                <h2>Контактная информация</h2>
                <p>Администратор: {{ with secret "secret/data/nginx/contacts" }}{{ .Data.data.admin_email }}{{ end }}</p>
                <p>Телефон поддержки: {{ with secret "secret/data/nginx/contacts" }}{{ .Data.data.support_phone }}{{ end }}</p>
            </section>
        </main>
        
        <footer>
            <p>&copy; {{ with secret "secret/data/nginx/site" }}{{ .Data.data.copyright_year }}{{ end }} Все права защищены.</p>
        </footer>
    </div>
</body>
</html>
