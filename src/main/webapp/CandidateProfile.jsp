<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hồ Sơ Ứng Viên - JobPortal</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: '#3b82f6',
                            secondary: '#64748b',
                            accent: '#f59e0b',
                            success: '#10b981',
                            danger: '#ef4444',
                            warning: '#f59e0b'
                        }
                    }
                }
            }
        </script>
    </head>
    <body class="bg-gray-50 min-h-screen">
        <!-- Alert Messages -->
        <c:if test="${not empty sessionScope.errorMessage}">
            <div id="errorAlert" class="fixed top-4 right-4 z-50 bg-red-500 text-white px-6 py-3 rounded-lg shadow-lg">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-circle mr-2"></i>
                    <span>${sessionScope.errorMessage}</span>
                    <button onclick="closeAlert('errorAlert')" class="ml-4 text-white hover:text-gray-200">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            </div>
            <c:remove var="errorMessage" scope="session" />
        </c:if>

        <c:if test="${not empty sessionScope.successMessage}">
            <div id="successAlert" class="fixed top-4 right-4 z-50 bg-green-500 text-white px-6 py-3 rounded-lg shadow-lg">
                <div class="flex items-center">
                    <i class="fas fa-check-circle mr-2"></i>
                    <span>${sessionScope.successMessage}</span>
                    <button onclick="closeAlert('successAlert')" class="ml-4 text-white hover:text-gray-200">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            </div>
            <c:remove var="successMessage" scope="session" />
        </c:if>

        <!-- Navigation -->
        <nav class="bg-white shadow-sm border-b border-gray-200">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center h-16">
                    <div class="flex items-center">
                        <h1 class="text-2xl font-bold text-primary">JobPortal</h1>
                    </div>
                    <div class="hidden md:flex space-x-8">
                        <a href="#" class="text-primary font-medium">Việc làm</a>
                        <a href="#" class="text-gray-600 hover:text-primary">Công ty</a>
                        <a href="#" class="text-gray-600 hover:text-primary">Lương</a>
                        <a href="#" class="text-gray-600 hover:text-primary">Tài nguyên</a>
                    </div>
                    <div class="md:hidden">
                        <button class="text-gray-600 hover:text-primary">
                            <i class="fas fa-bars text-xl"></i>
                        </button>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <!-- Profile Header -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden mb-8">
                <div class="bg-gradient-to-r from-blue-400 to-blue-600 h-12 mb-8"></div>
                <div class="px-6 pb-6">
                    <div class="flex flex-col sm:flex-row items-center sm:items-end -mt-16 mb-6">
                        <div class="relative">
                            <img src="${candidate.imageUrl}" alt="Avatar" 
                                 class="w-32 h-32 rounded-full border-4 border-white shadow-lg object-cover bg-gray-200" />
                            <button onclick="openModal('avatarModal')" class="absolute bottom-2 right-2 bg-primary text-white w-8 h-8 flex items-center justify-center rounded-full shadow-lg hover:bg-blue-600 transition-colors">
                                <i class="fas fa-camera text-sm"></i>
                            </button>
                        </div>

                        <div class="mt-4 sm:mt-0 sm:ml-6 text-center sm:text-left flex-1">
                            <h2 class="text-3xl font-bold text-gray-900">${candidate.fullName}</h2>
                            <div class="flex items-center justify-center sm:justify-start mt-2">
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium ${candidate.isActive eq 'True' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                    <i class="fas ${candidate.isActive eq 'True' ? 'fa-check-circle' : 'fa-times-circle'} mr-1"></i>
                                    ${candidate.isActive eq 'True' ? 'Đang hoạt động' : 'Đã bị hạn chế'}
                                </span>
                            </div>
                        </div>
                        <div class="mt-4 sm:mt-0">
                            <button onclick="openModal('editProfileModal')" 
                                    class="bg-primary text-white px-6 py-2 rounded-lg hover:bg-blue-600 transition-colors flex items-center">
                                <i class="fas fa-edit mr-2"></i>
                                Chỉnh sửa hồ sơ
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Profile Information -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
                <!-- Personal Information -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div class="flex items-center mb-6">
                        <div class="bg-blue-100 p-3 rounded-lg">
                            <i class="fas fa-user text-primary text-xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-900 ml-4">Thông tin cá nhân</h3>
                    </div>
                    <div class="space-y-4">
                        <div class="flex justify-between items-center py-3 border-b border-gray-100">
                            <span class="text-gray-600 font-medium">Họ tên:</span>
                            <span class="text-gray-900">${candidate.fullName}</span>
                        </div>
                        <div class="flex justify-between items-center py-3 border-b border-gray-100">
                            <span class="text-gray-600 font-medium">Giới tính:</span>
                            <span class="text-gray-900">
                                <c:choose>
                                    <c:when test="${candidate.gender == 'Male'}">Nam</c:when>
                                    <c:when test="${candidate.gender == 'Female'}">Nữ</c:when>
                                    <c:when test="${candidate.gender == 'Other'}">Khác</c:when>
                                    <c:otherwise>Không xác định</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="flex justify-between items-center py-3">
                            <span class="text-gray-600 font-medium">Ngày sinh:</span>
                            <span class="text-gray-900">${candidate.birthdate}</span>
                        </div>
                    </div>
                </div>

                <!-- Contact Information -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div class="flex items-center mb-6">
                        <div class="bg-green-100 p-3 rounded-lg">
                            <i class="fas fa-phone text-green-600 text-xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-900 ml-4">Thông tin liên lạc</h3>
                    </div>
                    <div class="space-y-4">
                        <div class="flex justify-between items-center py-3 border-b border-gray-100">
                            <span class="text-gray-600 font-medium">Số điện thoại:</span>
                            <span class="text-gray-900">${candidate.phone}</span>
                        </div>
                        <div class="flex justify-between items-center py-3 border-b border-gray-100">
                            <span class="text-gray-600 font-medium">Email:</span>
                            <span class="text-gray-900">${candidate.email}</span>
                        </div>
                        <div class="flex justify-between items-center py-3">
                            <span class="text-gray-600 font-medium">Địa chỉ:</span>
                            <span class="text-gray-900">${candidate.address}</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- CV Management -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-8">
                <div class="flex items-center justify-between mb-6">
                    <div class="flex items-center">
                        <div class="bg-purple-100 p-3 rounded-lg">
                            <i class="fas fa-file-alt text-purple-600 text-xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-900 ml-4">CV của bạn</h3>
                    </div>
                    <button onclick="openModal('cvModal')" 
                            class="bg-primary text-white px-6 py-2 rounded-lg hover:bg-blue-600 transition-colors flex items-center">
                        <i class="fas fa-plus mr-2"></i>
                        Thêm CV mới
                    </button>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <c:forEach var="item" items="${cvList}">
                        <div class="bg-gray-50 rounded-lg p-6 border border-gray-200 hover:shadow-md transition-shadow">
                            <div class="text-center">
                                <div class="bg-blue-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="fas fa-file-alt text-blue-600 text-2xl"></i>
                                </div>
                                <h4 class="font-semibold text-gray-900 mb-4">${item.title}</h4>
                                <div class="space-y-2">
                                    <form action="EditCV" method="get" class="w-full">
                                        <input type="hidden" name="cvId" value="${item.cvId}" />
                                        <button type="submit" class="w-full bg-primary text-white py-2 px-4 rounded-lg hover:bg-blue-600 transition-colors">
                                            <i class="fas fa-edit mr-2"></i>Chỉnh sửa
                                        </button>
                                    </form>
                                    <form action="CandidateProfile" method="get" class="w-full" 
                                          onsubmit="return confirm('Bạn chắc chắn muốn xóa CV này?');">
                                        <input type="hidden" name="cvId" value="${item.cvId}" />
                                        <button type="submit" class="w-full bg-red-500 text-white py-2 px-4 rounded-lg hover:bg-red-600 transition-colors">
                                            <i class="fas fa-trash mr-2"></i>Xóa CV
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- CV Templates -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                <div class="flex items-center justify-between mb-6">
                    <div class="flex items-center">
                        <div class="bg-orange-100 p-3 rounded-lg">
                            <i class="fas fa-layer-group text-orange-600 text-xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-900 ml-4">Mẫu CV của bạn</h3>
                    </div>
                    <button onclick="window.location.href = 'CVTemplate'" 
                            class="bg-warning text-white px-6 py-2 rounded-lg hover:bg-yellow-600 transition-colors flex items-center">
                        <i class="fas fa-plus mr-2"></i>
                        Tạo CV theo mẫu
                    </button>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <c:forEach var="item" items="${cvTemplateList}">
                        <div class="bg-gray-50 rounded-lg p-6 border border-gray-200 hover:shadow-md transition-shadow">
                            <div class="text-center">
                                <div class="bg-orange-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="fas fa-layer-group text-orange-600 text-2xl"></i>
                                </div>
                                <h4 class="font-semibold text-gray-900 mb-4">${item.title}</h4>
                                <div class="space-y-2">
                                    <form action="EditTemplateCV" method="get" class="w-full">
                                        <input type="hidden" name="templateId" value="${item.cvId}" />
                                        <button type="submit" class="w-full bg-primary text-white py-2 px-4 rounded-lg hover:bg-blue-600 transition-colors">
                                            <i class="fas fa-edit mr-2"></i>Chỉnh sửa
                                        </button>
                                    </form>
                                    <form action="DeleteCVTemplate" method="get" class="w-full" 
                                          onsubmit="return confirm('Bạn chắc chắn muốn xóa mẫu CV này?');">
                                        <input type="hidden" name="cvId" value="${item.cvId}" />
                                        <button type="submit" class="w-full bg-red-500 text-white py-2 px-4 rounded-lg hover:bg-red-600 transition-colors">
                                            <i class="fas fa-trash mr-2"></i>Xóa mẫu
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- Edit Profile Modal -->
        <div id="editProfileModal" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center p-4">
            <div class="bg-white rounded-xl shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
                <form action="CandidateProfile" method="post">
                    <div class="p-6 border-b border-gray-200">
                        <div class="flex items-center justify-between">
                            <h3 class="text-xl font-semibold text-gray-900">Chỉnh sửa thông tin cá nhân</h3>
                            <button type="button" onclick="closeModal('editProfileModal')" class="text-gray-400 hover:text-gray-600">
                                <i class="fas fa-times text-xl"></i>
                            </button>
                        </div>
                    </div>
                    <div class="p-6">
                        <input type="hidden" name="candidateId" value="${candidate.candidateId}">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Họ tên</label>
                                <input type="text" name="fullName" required value="${candidate.fullName}" required
                                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Giới tính</label>
                                <select name="gender" required class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                    <option value="Male" ${candidate.gender == 'Male' ? 'selected' : ''}>Nam</option>
                                    <option value="Female" ${candidate.gender == 'Female' ? 'selected' : ''}>Nữ</option>
                                    <option value="Other" ${candidate.gender == 'Other' ? 'selected' : ''}>Khác</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Ngày sinh</label>
                                <input type="date" name="birthdate" required value="${candidate.birthdate}"
                                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                            </div>
                            <div class="relative">
                                <label class="block text-sm font-medium text-gray-700 mb-2">Số điện thoại</label>
                                <input id="phoneInput" type="text" required name="phone" value="${candidate.phone}" pattern="[0-9]{10,15}"
                                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                <!-- error message placeholder -->
                                <p id="phoneError" class="mt-1 text-sm text-red-600 hidden"></p>
                            </div>

                            <div class="md:col-span-2">
                                <label class="block text-sm font-medium text-gray-700 mb-2">Địa chỉ</label>
                                <input type="text" name="address" required value="${candidate.address}"
                                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                            </div>
                        </div>
                    </div>
                    <div class="p-6 border-t border-gray-200 flex justify-end space-x-3">
                        <button type="button" onclick="closeModal('editProfileModal')" 
                                class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-colors">
                            Hủy
                        </button>
                        <button type="submit" class="px-6 py-2 bg-primary text-white rounded-lg hover:bg-blue-600 transition-colors">
                            Lưu thay đổi
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Avatar Modal -->
        <div id="avatarModal" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center p-4">
            <div class="bg-white rounded-xl shadow-xl max-w-md w-full">
                <form action="UploadImageServlet" method="post" enctype="multipart/form-data">
                    <div class="p-6 border-b border-gray-200">
                        <div class="flex items-center justify-between">
                            <h3 class="text-xl font-semibold text-gray-900">Cập nhật ảnh đại diện</h3>
                            <button type="button" onclick="closeModal('avatarModal')" class="text-gray-400 hover:text-gray-600">
                                <i class="fas fa-times text-xl"></i>
                            </button>
                        </div>
                    </div>
                    <div class="p-6 text-center">
                        <img id="preview" src="#" alt="Xem trước" class="hidden w-48 h-48 object-cover rounded-full mx-auto mb-4 border-4 border-gray-200">
                        <div class="border-2 border-dashed border-gray-300 rounded-lg p-6 mb-4">
                            <i class="fas fa-cloud-upload-alt text-4xl text-gray-400 mb-4"></i>
                            <input type="file" name="avatar" id="imageInput" accept=".png,.jpg,.jpeg" onchange="previewImage(event)"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                        </div>
                        <input type="hidden" name="candidateId" value="${candidate.candidateId}">
                    </div>
                    <div class="p-6 border-t border-gray-200 flex justify-end space-x-3">
                        <button type="button" onclick="closeModal('avatarModal')" 
                                class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-colors">
                            Hủy
                        </button>
                        <button type="submit" class="px-6 py-2 bg-primary text-white rounded-lg hover:bg-blue-600 transition-colors">
                            Lưu ảnh
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- CV Modal -->
        <div id="cvModal" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center p-4">
            <div class="bg-white rounded-xl shadow-xl max-w-md w-full">
                <div class="p-6 border-b border-gray-200">
                    <div class="flex items-center justify-between">
                        <h3 class="text-xl font-semibold text-gray-900">Thêm CV mới</h3>
                        <button type="button" onclick="closeModal('cvModal')" class="text-gray-400 hover:text-gray-600">
                            <i class="fas fa-times text-xl"></i>
                        </button>
                    </div>
                </div>
                <div class="p-6 space-y-4">
                    <button onclick="window.location.href = 'AddCVManual'" 
                            class="w-full bg-green-50 border border-green-200 text-green-700 py-4 px-6 rounded-lg hover:bg-green-100 transition-colors flex items-center justify-center">
                        <i class="fas fa-edit mr-3 text-xl"></i>
                        <span class="font-medium">Tạo CV thủ công</span>
                    </button>
                    <div class="border-t border-gray-200 pt-4">
                        <form action="OCRServlet" method="post" enctype="multipart/form-data" id="ocrForm">
                            <div class="mb-4">
                                <label class="block text-sm font-medium text-gray-700 mb-2">Tải lên CV để quét tự động</label>
                                <input type="file" name="cvFile" accept=".pdf,.png,.jpg,.jpeg" required
                                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                <input type="hidden" name="candidateId" value="${candidate.candidateId}">
                                <p class="text-sm text-gray-500 mt-2">Hỗ trợ: PNG, JPG, PDF</p>
                            </div>
                            <button type="submit" class="w-full bg-purple-600 text-white py-3 px-6 rounded-lg hover:bg-purple-700 transition-colors flex items-center justify-center">
                                <i class="fas fa-magic mr-2"></i>
                                Quét CV tự động
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Loading Overlay -->
        <div id="loadingOverlay" class="fixed inset-0 bg-black bg-opacity-75 hidden z-50 flex items-center justify-center">
            <div class="bg-white rounded-xl p-8 max-w-md w-full mx-4 text-center">
                <div class="animate-spin rounded-full h-16 w-16 border-b-2 border-primary mx-auto mb-4"></div>
                <h3 class="text-xl font-semibold text-gray-900 mb-2">Đang xử lý CV của bạn</h3>
                <p class="text-gray-600 mb-4">Vui lòng đợi trong khi chúng tôi phân tích tài liệu...</p>
                <div class="w-full bg-gray-200 rounded-full h-2 mb-4">
                    <div class="bg-primary h-2 rounded-full animate-pulse" style="width: 60%"></div>
                </div>
                <div class="space-y-2 text-left">
                    <div class="flex items-center text-sm text-gray-600">
                        <i class="fas fa-check-circle text-green-500 mr-2"></i>
                        Đang tải lên tài liệu...
                    </div>
                    <div class="flex items-center text-sm text-gray-600">
                        <i class="fas fa-spinner fa-spin text-primary mr-2"></i>
                        Đang quét nội dung...
                    </div>
                    <div class="flex items-center text-sm text-gray-400">
                        <i class="fas fa-circle mr-2"></i>
                        Đang trích xuất văn bản...
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Modal functions
            function openModal(modalId) {
                document.getElementById(modalId).classList.remove('hidden');
                document.body.style.overflow = 'hidden';
            }

            function closeModal(modalId) {
                document.getElementById(modalId).classList.add('hidden');
                document.body.style.overflow = 'auto';
            }

            // Alert functions
            function closeAlert(alertId) {
                document.getElementById(alertId).style.display = 'none';
            }

            // Auto-hide alerts after 5 seconds
            setTimeout(() => {
                const alerts = document.querySelectorAll('[id$="Alert"]');
                alerts.forEach(alert => {
                    if (alert)
                        alert.style.display = 'none';
                });
            }, 5000);

            // Image preview function
            function previewImage(event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const img = document.getElementById('preview');
                        img.src = e.target.result;
                        img.classList.remove('hidden');
                    }
                    reader.readAsDataURL(file);
                }
            }

            // Phone validation
            document.addEventListener('DOMContentLoaded', function () {
                const existingPhones = [
            <c:forEach var="p" items="${phoneList}" varStatus="status">
                '${fn:escapeXml(p)}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
                ].filter(p => p && p.trim() !== '');

                const phoneInput = document.getElementById('phoneInput');
                const phoneError = document.getElementById('phoneError');
                const submitBtn = document.querySelector('#editProfileModal button[type="submit"]');

                if (!phoneInput || !submitBtn)
                    return;

                function showError(msg) {
                    phoneError.textContent = msg;
                    phoneError.classList.remove('hidden');
                    phoneInput.classList.add('border-red-500');
                    submitBtn.disabled = true;
                }

                function clearError() {
                    phoneError.textContent = '';
                    phoneError.classList.add('hidden');
                    phoneInput.classList.remove('border-red-500');
                    submitBtn.disabled = false;
                }

                phoneInput.addEventListener('blur', function () {
                    const val = phoneInput.value.trim();
                    if (!val) {
                        clearError();
                        return;
                    }

                    if (!/^[0-9]{10,15}$/.test(val)) {
                        showError('Số điện thoại phải gồm 10–15 chữ số.');
                        return;
                    }

                    if (existingPhones.includes(val)) {
                        showError('Số điện thoại này đã được sử dụng.');
                        return;
                    }

                    clearError();
                });
            });


            // OCR form handling
            document.getElementById('ocrForm').addEventListener('submit', function (e) {
                const fileInput = document.querySelector('input[name="cvFile"]');
                if (!fileInput.files || fileInput.files.length === 0) {
                    e.preventDefault();
                    alert('Vui lòng chọn file CV trước khi tải lên.');
                    return;
                }

                closeModal('cvModal');
                document.getElementById('loadingOverlay').classList.remove('hidden');
            });

            // Close modals when clicking outside
            document.addEventListener('click', function (e) {
                if (e.target.classList.contains('fixed') && e.target.classList.contains('inset-0')) {
                    const modalId = e.target.id;
                    if (modalId) {
                        closeModal(modalId);
                    }
                }
            });
        </script>
    </body>
</html>
