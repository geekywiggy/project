// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract AttendanceTracker {
    
    // Structure to hold attendance data for each student
    struct Attendance {
        uint256[] dates; // List of dates when attendance was marked
        mapping(uint256 => bool) attendanceDates; // Date in UNIX timestamp format
    }

    // Mapping from student ID to their attendance record
    mapping(address => Attendance) private studentAttendance;
    
    // Events for logging attendance actions
    event AttendanceMarked(address indexed student, uint256 date, bool status);

    // Function to mark attendance for a student
    function markAttendance(address student, uint256 date) public {
        Attendance storage attendance = studentAttendance[student];
        
        // Ensure the date is not already recorded
        require(!attendance.attendanceDates[date], "Attendance already marked for this date");
        
        // Mark the attendance
        attendance.attendanceDates[date] = true;
        attendance.dates.push(date);

        // Emit an event for attendance marking
        emit AttendanceMarked(student, date, true);
    }

    // Function to check attendance for a student on a specific date
    function isAttendanceMarked(address student, uint256 date) public view returns (bool) {
        return studentAttendance[student].attendanceDates[date];
    }

    // Function to retrieve all attendance dates for a student
    function getAttendanceDates(address student) public view returns (uint256[] memory) {
        return studentAttendance[student].dates;
    }
}
