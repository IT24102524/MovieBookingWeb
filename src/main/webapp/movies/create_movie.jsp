<%@ include file="../header.jsp" %>

<h1 class="mb-4">Add New Movie</h1>

<form action="movies" method="post" class="needs-validation" novalidate>
    <input type="hidden" name="action" value="create" />

    <div class="mb-3">
        <label class="form-label">Movie ID</label>
        <input name="movieId" type="text" class="form-control" required />
        <div class="invalid-feedback">Please enter Movie ID.</div>
    </div>

    <div class="mb-3">
        <label class="form-label">Title</label>
        <input name="title" type="text" class="form-control" required />
        <div class="invalid-feedback">Please enter Title.</div>
    </div>

    <div class="mb-3">
        <label class="form-label">Duration (minutes)</label>
        <input name="duration" type="number" min="1" class="form-control" required />
        <div class="invalid-feedback">Please enter Duration.</div>
    </div>

    <div class="mb-3">
        <label class="form-label">Release Date</label>
        <input name="releaseDate" type="date" class="form-control" required />
        <div class="invalid-feedback">Please enter Release Date.</div>
    </div>

    <div class="mb-3">
        <label class="form-label">Poster Image Filename</label>
        <input name="posterImage" type="text" class="form-control" />
    </div>

    <div class="mb-3">
        <label class="form-label">Available Seats</label>
        <input name="availableSeats" type="number" min="0" class="form-control" required />
        <div class="invalid-feedback">Please enter Available Seats.</div>
    </div>

    <div class="mb-3">
        <label class="form-label">Price</label>
        <input name="price" type="number" min="0" step="0.01" class="form-control" required />
        <div class="invalid-feedback">Please enter Price.</div>
    </div>

    <div class="mb-3">
        <label class="form-label fw-bold">Showtimes</label>
        <div id="showtimesContainer">
            <div class="row mb-2 showtime-row">
                <div class="col">
                    <input type="date" name="showDate" class="form-control" required />
                </div>
                <div class="col">
                    <input type="time" name="showTime" class="form-control" required />
                </div>
                <div class="col-auto">
                    <button type="button" class="btn btn-danger removeShowtimeBtn">Remove</button>
                </div>
            </div>
        </div>
        <button type="button" class="btn btn-secondary mt-2" id="addShowtimeBtn">Add Showtime</button>
    </div>

    <button type="submit" class="btn btn-primary">Create Movie</button>
    <a href="movies?action=adminList" class="btn btn-secondary ms-2">Cancel</a>
</form>

<script>
    document.getElementById('addShowtimeBtn').addEventListener('click', function() {
        const container = document.getElementById('showtimesContainer');
        const firstRow = container.querySelector('.showtime-row');
        const newRow = firstRow.cloneNode(true);
        newRow.querySelectorAll('input').forEach(input => input.value = '');
        container.appendChild(newRow);
    });

    document.getElementById('showtimesContainer').addEventListener('click', function(e) {
        if (e.target.classList.contains('removeShowtimeBtn')) {
            const rows = document.querySelectorAll('.showtime-row');
            if (rows.length > 1) {
                e.target.closest('.showtime-row').remove();
            }
        }
    });

    (() => {
        'use strict';
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', e => {
                if (!form.checkValidity()) {
                    e.preventDefault();
                    e.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();
</script>

<%@ include file="../footer.jsp" %>
