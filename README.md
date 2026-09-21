# 🛋️ Furni — Furniture E-Commerce Web Application

<p align="center">
  <b>A full-stack furniture e-commerce web application built with Java, JSP & Servlets.</b>
</p>

<p align="center">

[![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge\&logo=openjdk\&logoColor=white)](https://www.java.com/)
[![JSP](https://img.shields.io/badge/JSP-Servlets-6DB33F?style=for-the-badge)](https://jakarta.ee/)
[![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge\&logo=mysql\&logoColor=white)](https://www.mysql.com/)
[![Razorpay](https://img.shields.io/badge/Razorpay-02042B?style=for-the-badge\&logo=razorpay\&logoColor=white)](https://razorpay.com/)
[![Cloudinary](https://img.shields.io/badge/Cloudinary-3448C5?style=for-the-badge\&logo=cloudinary\&logoColor=white)](https://cloudinary.com/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge\&logo=docker\&logoColor=white)](https://www.docker.com/)

</p>

<p align="center">
  <a href="https://javafurnitureproject.onrender.com/Furni/">🌐 Live Demo</a>
  &nbsp; • &nbsp;
  <a href="https://github.com/Er-Lalit/JavaFurnitureProject">💻 GitHub Repository</a>
</p>

---

## 📖 About

**Furni** is a furniture e-commerce web application developed using **Java, JSP and Servlets**.

The application provides a complete shopping workflow, including user registration and authentication, product browsing, cart management, order placement and online payment.

It also includes an **admin panel** for managing users and products, along with integrations for **Razorpay** payments and **Cloudinary** image storage.

---

## ✨ Features

### 👤 User

* 🔐 User registration & login
* 📱 OTP-based account verification
* 🔑 Forgot password & OTP-based password reset
* 🛍️ Browse furniture products
* 🛒 Add and manage products in cart
* 📦 Product quantity & stock handling
* 💳 Online payment using Razorpay
* 🧾 Order management

### 👨‍💼 Admin

* 🔐 Admin authentication
* 🛡️ Admin access control
* 👥 User block / unblock
* 🖼️ Product image management using Cloudinary
* 📦 Product and stock management

---

## 🛠️ Tech Stack

| Technology                    | Usage                              |
| ----------------------------- | ---------------------------------- |
| ☕ **Java**                    | Backend development                |
| 🌐 **JSP & Servlets**         | Web application & request handling |
| 🎨 **HTML, CSS & JavaScript** | Frontend                           |
| 🗄️ **MySQL**                 | Database                           |
| 🔌 **JDBC**                   | Database connectivity              |
| 💳 **Razorpay**               | Payment processing                 |
| 🖼️ **Cloudinary**            | Product image storage              |
| 🖥️ **Apache Tomcat**         | Application server                 |
| 🐳 **Docker**                 | Containerization                   |
| ☁️ **Render**                 | Deployment                         |

---

## 🏗️ Application Flow

```text
                    ┌───────────────┐
                    │     User      │
                    └───────┬───────┘
                            │
                            ▼
                    ┌───────────────┐
                    │   JSP Pages   │
                    └───────┬───────┘
                            │
                            ▼
                    ┌───────────────┐
                    │   Servlets    │
                    └───────┬───────┘
                            │
                    ┌───────┴────────┐
                    ▼                ▼
              ┌──────────┐    ┌─────────────┐
              │   JDBC   │    │ Third-Party │
              └────┬─────┘    │    APIs     │
                   │          └──────┬──────┘
                   ▼                 │
              ┌──────────┐     ┌─────┴──────┐
              │  MySQL   │     │  Razorpay  │
              └──────────┘     │ Cloudinary │
                               └────────────┘
```

---

# 📸 Application Preview

### 🏠 Home Page

<p align="center">
  <img src="<img width="802" height="620" alt="Screenshot 2026-09-21 115207" src="https://github.com/user-attachments/assets/6358da0a-cea6-40eb-b75c-aaa0813b2b6d" />
" alt="Furni Home Page" width="900">
</p>

### 🛍️ Shop

<p align="center">
  <img src="screenshots/shop.png" alt="Furni Shop" width="900">
</p>

### 🪑 Product Details

<p align="center">
  <img src="screenshots/product-details.png" alt="Furni Product Details" width="900">
</p>

### 🛒 Shopping Cart

<p align="center">
  <img src="screenshots/cart.png" alt="Furni Shopping Cart" width="900">
</p>

### 💳 Payment

<p align="center">
  <img src="screenshots/payment.png" alt="Furni Payment" width="900">
</p>

### 📦 Orders

<p align="center">
  <img src="screenshots/orders.png" alt="Furni Orders" width="900">
</p>

### 👨‍💼 Admin Panel

<p align="center">
  <img src="screenshots/admin.png" alt="Furni Admin Panel" width="900">
</p>

# 📂 Project Structure

```text
JavaFurnitureProject/
│
├── src/
│   └── main/
│       ├── java/
│       │   └── ...
│       │
│       └── webapp/
│           └── ...
│
├── build/
├── Dockerfile
├── Furni.war
├── .gitignore
├── .classpath
└── .project
```

---

# 🚀 Getting Started

## Prerequisites

Make sure you have:

* Java JDK
* Apache Tomcat
* MySQL
* Git
* Docker *(optional)*

## 1. Clone the Repository

```bash
git clone https://github.com/Er-Lalit/JavaFurnitureProject.git
cd JavaFurnitureProject
```

## 2. Configure MySQL

Create the required database and configure the database connection used by the application.

Update the JDBC configuration with your:

```text
Database URL
Username
Password
```

## 3. Configure API Credentials

Configure the required credentials for:

* Razorpay
* Cloudinary
* OTP service, if applicable

**Do not commit private API keys or secrets to GitHub.**

## 4. Run Using Tomcat

Deploy `Furni.war` to your Apache Tomcat server.

Then open:

```text
http://localhost:8080/Furni/
```

## 🐳 Run with Docker

Build the Docker image:

```bash
docker build -t furni .
```

Run the container:

```bash
docker run -p 8080:8080 furni
```

---

# 🌐 Live Project

### 🚀 [Open Furni Live](https://javafurnitureproject.onrender.com/Furni/)

### 💻 [View Source Code on GitHub](https://github.com/Er-Lalit/JavaFurnitureProject)

---

## 👨‍💻 Developer

### **Lalit Kumar**

Java Developer | Full-Stack Web Development

[LinkedIn](https://www.linkedin.com/in/lalit-kumar)

---

<p align="center">
  ⭐ If you found this project interesting, consider giving it a star on GitHub.
</p>
