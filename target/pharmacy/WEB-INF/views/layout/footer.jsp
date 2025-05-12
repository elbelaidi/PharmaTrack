                </main>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Initialize tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });

        // Auto-hide alerts after 5 seconds
        // document.addEventListener('DOMContentLoaded', function() {
        //     var alerts = document.querySelectorAll('.alert');
        //     alerts.forEach(function(alert) {
        //         setTimeout(function() {
        //             alert.style.opacity = '0';
        //             setTimeout(function() {
        //                 alert.style.display = 'none';
        //             }, 500);
        //         }, 5000);
        //     });
        // });
    </script>
</body>
</html> 