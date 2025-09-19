<body>
<div class="container-fluid">
    <div class="content-overlay">
        <div class="dental-header">
            <h1><i class="fas fa-tooth tooth-icon"></i>Dental Clinic Patient Management</h1>
            <p class="lead">Managing smiles, one patient at a time</p>
        </div>

        <!-- Success/Deleted Message -->
        <c:if test="${not empty param.message}">
            <div class="alert
                <c:choose>
                    <c:when test="${param.message == 'success'}">alert-success</c:when>
                    <c:when test="${param.message == 'deleted'}">alert-danger</c:when>
                    <c:otherwise>alert-info</c:otherwise>
                </c:choose>
                alert-dismissible fade show text-center" role="alert">
                <i class="fas
                    <c:choose>
                        <c:when test="${param.message == 'success'}">fa-check-circle</c:when>
                        <c:when test="${param.message == 'deleted'}">fa-trash-alt</c:when>
                    </c:choose>"></i>
                <strong>
                    <c:choose>
                        <c:when test="${param.message == 'success'}">Success!</c:when>
                        <c:when test="${param.message == 'deleted'}">Deleted!</c:when>
                    </c:choose>
                </strong>
                <c:choose>
                    <c:when test="${param.message == 'success'}"> Patient record saved successfully.</c:when>
                    <c:when test="${param.message == 'deleted'}"> Patient record deleted successfully.</c:when>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- Only ONE Add Button Section -->
        <div class="add-btn-section text-center">
            <a href="${pageContext.request.contextPath}/patients?action=new" class="btn btn-primary add-btn">
                <i class="fas fa-user-plus"></i> Add New Patient
            </a>
        </div>

        <!-- Patient Table -->
        <div class="table-container">
            <div class="table-responsive">
                <table class="table table-striped table-hover mb-0">
                    <thead>
                    <tr>
                        <th><i class="fas fa-id-card"></i> ID</th>
                        <th><i class="fas fa-user"></i> First Name</th>
                        <th><i class="fas fa-user"></i> Last Name</th>
                        <th><i class="fas fa-envelope"></i> Email</th>
                        <th><i class="fas fa-phone"></i> Phone</th>
                        <th><i class="fas fa-map-marker-alt"></i> Address</th>
                        <th><i class="fas fa-birthday-cake"></i> DOB</th>
                        <th><i class="fas fa-notes-medical"></i> Medical History</th>
                        <th><i class="fas fa-cogs"></i> Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${patients}">
                        <tr>
                            <td>${p.patientId}</td>
                            <td>${p.firstName}</td>
                            <td>${p.lastName}</td>
                            <td>${p.email}</td>
                            <td>${p.phone}</td>
                            <td>${p.address}</td>
                            <td>${p.dateOfBirth}</td>
                            <td>${p.medicalHistory}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/patients?action=edit&id=${p.patientId}"
                                   class="btn btn-primary btn-sm btn-edit">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/patients?action=delete&id=${p.patientId}"
                                   class="btn btn-danger btn-sm btn-delete"
                                   onclick="return confirm('Are you sure you want to delete this patient?');">
                                    <i class="fas fa-trash"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>