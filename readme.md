## Project Setup:

### 1. Clone the repo to htdocs or www folder

```
git clone ....
```

### 2. go to the directory 

```
cd ccKnowledgeBase
```

### 3. Install Composer
```
composer install
```

### 4. Enable Permission (for Linux User)

```
sudo chmod -R 777 storage

```

## 5. Database Section

```
Create db kbs
```
```
php artisan migrate
```
```
 php artisan db:seed --class=PermissionTableSeeder
```
```
 php artisan db:seed --class=RoleTableSeeder
```
```
 php artisan db:seed --class=UserTableSeeder
```

## 6. Authentication

```
php artisan passport:install
```

# Great ! Done! 

## 7. From Browser
```html
http://localhost/ccKnowledgeBase/public
```

### 8. From Postman ### post request
```html
http://localhost/ccKnowledgeBase/public/api/login

body: 
    username: admin
    password: 123456

```


