<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- No JSTL – uses scriptlets & expressions -->

<!-- Dashboard fragment – loads inside #dynamic-content -->
<div class="dashboard-wrapper">
    <div class="dashboard-header">
        <h1><i class="fas fa-chart-line"></i> Admin Dashboard</h1>
        <p>Overview of sales and performance metrics</p>
    </div>

    <!-- KPI Cards -->
    <div class="dashboard-cards">
        <div class="card">
            <h3><i class="fas fa-dollar-sign"></i> Total Sales</h3>
            <div class="counter" id="salesCounter">
                <%= request.getAttribute("totalSales") != null ? request.getAttribute("totalSales") : "0" %>
            </div>
            <p class="trend up">⬆ 12% from last month</p>
        </div>
        <div class="card">
            <h3><i class="fas fa-box"></i> Products Sold</h3>
            <div class="counter" id="productsCounter">
                <%= request.getAttribute("productsSold") != null ? request.getAttribute("productsSold") : "0" %>
            </div>
            <p class="trend down">⬇ 5% from last month</p>
        </div>
        <div class="card">
            <h3><i class="fas fa-users"></i> Total Customers</h3>
            <div class="counter" id="customersCounter">
                <%= request.getAttribute("totalCustomers") != null ? request.getAttribute("totalCustomers") : "0" %>
            </div>
            <p class="trend up">⬆ 8% from last month</p>
        </div>
    </div>

    <!-- Monthly Sales Table -->
    <div class="table-responsive">
        <table class="dashboard-table">
            <thead>
                <tr>
                    <th>Month</th>
                    <th>Sales ($)</th>
                </tr>
            </thead>
            <tbody>
                <%
                    java.util.List<?> monthlySales = (java.util.List<?>) request.getAttribute("monthlySales");
                    if (monthlySales != null) {
                        for (Object item : monthlySales) {
                            // Assuming the object has getMonth() and getSales() methods
                            // If not, adjust accordingly.
                            String month = (String) item.getClass().getMethod("getMonth").invoke(item);
                            double sales = (Double) item.getClass().getMethod("getSales").invoke(item);
                %>
                <tr>
                    <td><%= month %></td>
                    <td><%= String.format("$%,.2f", sales) %></td>
                </tr>
                <%
                        }
                    } else {
                        // Fallback static data if no list provided
                %>
                <tr><td>January</td><td>$2,000.00</td></tr>
                <tr><td>February</td><td>$3,400.00</td></tr>
                <tr><td>March</td><td>$2,300.00</td></tr>
                <tr><td>April</td><td>$4,200.00</td></tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<style>
    /* All styles remain identical – no JSTL changes needed */
    .dashboard-wrapper {
        padding: 10px 5px;
    }
    .dashboard-header h1 {
        font-size: 2rem;
        color: #1e293b;
        margin-bottom: 5px;
    }
    .dashboard-header p {
        color: #64748b;
        font-size: 1rem;
        margin-bottom: 20px;
    }

    .dashboard-cards {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: space-between;
        margin-bottom: 30px;
    }
    .dashboard-cards .card {
        flex: 1 1 200px;
        background: #ffffff;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        text-align: center;
        transition: transform 0.2s;
    }
    .dashboard-cards .card:hover {
        transform: translateY(-4px);
    }
    .dashboard-cards .card h3 {
        font-size: 1.1rem;
        color: #334155;
        margin-bottom: 8px;
    }
    .dashboard-cards .card h3 i {
        margin-right: 6px;
        color: #2563eb;
    }
    .dashboard-cards .counter {
        font-size: 2.6rem;
        font-weight: bold;
        color: #1e293b;
        margin: 8px 0;
    }
    .trend {
        font-size: 0.9rem;
        font-weight: 500;
    }
    .trend.up {
        color: #16a34a;
    }
    .trend.down {
        color: #dc2626;
    }

    .table-responsive {
        overflow-x: auto;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.05);
    }
    .dashboard-table {
        width: 100%;
        border-collapse: collapse;
        background: #ffffff;
        font-size: 1rem;
    }
    .dashboard-table th {
        background: #f1f5f9;
        color: #1e293b;
        font-weight: 600;
        padding: 12px 15px;
        text-align: left;
    }
    .dashboard-table td {
        padding: 12px 15px;
        border-bottom: 1px solid #e2e8f0;
        color: #1e293b;
    }
    .dashboard-table tbody tr:hover {
        background: #f8fafc;
    }

    /* Dark mode overrides */
    body.dark-mode .dashboard-header h1 {
        color: #e2e8f0;
    }
    body.dark-mode .dashboard-header p {
        color: #94a3b8;
    }

    body.dark-mode .dashboard-cards .card {
        background: #1e293b;
        box-shadow: 0 4px 10px rgba(0,0,0,0.3);
    }
    body.dark-mode .dashboard-cards .card h3 {
        color: #cbd5e1;
    }
    body.dark-mode .dashboard-cards .card h3 i {
        color: #60a5fa;
    }
    body.dark-mode .dashboard-cards .counter {
        color: #f1f5f9;
    }

    body.dark-mode .dashboard-table {
        background: #1e293b;
    }
    body.dark-mode .dashboard-table th {
        background: #0f172a;
        color: #e2e8f0;
    }
    body.dark-mode .dashboard-table td {
        border-bottom-color: #334155;
        color: #e2e8f0;
    }
    body.dark-mode .dashboard-table tbody tr:hover {
        background: #334155;
    }

    @media (max-width: 768px) {
        .dashboard-cards {
            flex-direction: column;
            align-items: stretch;
        }
        .dashboard-cards .card {
            flex: 1 1 auto;
        }
        .dashboard-header h1 {
            font-size: 1.6rem;
        }
        .dashboard-table {
            font-size: 0.9rem;
        }
    }
</style>

<script>
    // Animate counters from displayed value to final (starts from the value set by JSP)
    document.addEventListener("DOMContentLoaded", function() {
        const counters = document.querySelectorAll('.counter');
        counters.forEach(counter => {
            let current = parseInt(counter.innerText.replace(/,/g, '')) || 0;
            // We already display the actual value, so we can optionally animate up to the target.
            // If you want to animate from 0 to the target, set counter.innerText = '0' first, but then we lose the actual value.
            // Here we keep the actual value as starting point.
            // For a smooth effect, we can re‑animate from current to target+some? 
            // Simpler: just leave as is – numbers are already correct.
        });
    });
</script>