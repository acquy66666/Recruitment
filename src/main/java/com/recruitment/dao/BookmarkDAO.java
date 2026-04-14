package com.recruitment.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Data Access Object for managing bookmarked jobs
 */
public class BookmarkDAO extends DBcontext {
    
    private static final String BOOKMARK_STATUS = "bookmarked";
    
    /**
     * Add a job to bookmarks
     */
    public boolean addBookmark(int candidateId, int jobId) throws SQLException {
        System.out.println(" Adding bookmark: candidate=" + candidateId + ", job=" + jobId);
        
        // Check if already bookmarked
        if (isBookmarked(candidateId, jobId)) {
            System.out.println("ℹ️ Already bookmarked");
            return true;
        }
        
        String sql = "INSERT INTO [dbo].[bookmark] ([candidate_id], [job_id]) VALUES (?, ?)";
        
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, candidateId);
            st.setInt(2, jobId);
            
            boolean result = st.executeUpdate() > 0;
            System.out.println(result ? " Bookmark added successfully" : " Failed to add bookmark");
            return result;
        } catch (SQLException e) {
            System.err.println(" Error adding bookmark: " + e.getMessage());
            throw e;
        }
    }
    
    /**
     * Remove a job from bookmarks
     */
    public boolean removeBookmark(int candidateId, int jobId) throws SQLException {
    String sql = "DELETE FROM [dbo].[bookmark] WHERE [candidate_id] = ? AND [job_id] = ?";
    
    try (PreparedStatement st = c.prepareStatement(sql)) {
        st.setInt(1, candidateId);
        st.setInt(2, jobId);
        int rowsAffected = st.executeUpdate();
        boolean result = rowsAffected > 0;
   
        return result;
        
    } catch (SQLException e) {
        e.printStackTrace();
        throw e;
    }
    }
    
    /**
     * Check if a job is bookmarked
     */
    public boolean isBookmarked(int candidateId, int jobId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM [dbo].[bookmark] WHERE [candidate_id] = ? AND [job_id] = ?";
        
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, candidateId);
            st.setInt(2, jobId);
            
            try (ResultSet rs = st.executeQuery()) {
                boolean result = rs.next() && rs.getInt(1) > 0;
                System.out.println(" Bookmark check: candidate=" + candidateId + ", job=" + jobId + " -> " + result);
                return result;
            }
        } catch (SQLException e) {
            System.err.println(" Error checking bookmark: " + e.getMessage());
            throw e;
        }
    }
    
    /**
     * Get bookmarked jobs for a candidate
     */
    public List<Map<String, Object>> getBookmarkedJobs(int candidateId) throws SQLException {
        System.out.println("Getting bookmarked jobs for candidate: " + candidateId);
        
        String sql = "SELECT b.bookmark_id, b.job_id, b.candidate_id, " +
                    "jp.title, jp.location, jp.job_type, jp.experience_level, " +
                    "jp.salary_min, jp.salary_max, jp.deadline, " +
                    "r.company_name, r.email as company_email, " +
                    "CASE " +
                    "   WHEN jp.salary_min IS NOT NULL AND jp.salary_max IS NOT NULL " +
                    "   THEN CAST(jp.salary_min AS VARCHAR) + ' - ' + CAST(jp.salary_max AS VARCHAR) + ' VNĐ' " +
                    "   ELSE N'Thỏa thuận' " +
                    "END as salary, " +
                    "CASE " +
                    "   WHEN LEN(CAST(jp.description AS VARCHAR(MAX))) > 200 " +
                    "   THEN LEFT(CAST(jp.description AS VARCHAR(MAX)), 200) + '...' " +
                    "   ELSE CAST(jp.description AS VARCHAR(MAX)) " +
                    "END as short_description " +
                    "FROM [dbo].[bookmark] b " +
                    "INNER JOIN [dbo].[job_post] jp ON b.job_id = jp.job_id " +
                    "INNER JOIN [dbo].[recruiter] r ON jp.recruiter_id = r.recruiter_id " +
                    "WHERE b.candidate_id = ? " +
                    "ORDER BY b.bookmark_id DESC";
        
        List<Map<String, Object>> bookmarkedJobs = new ArrayList<>();
        
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, candidateId);
            
            System.out.println(" Executing query with candidate ID: " + candidateId);
            
            try (ResultSet rs = st.executeQuery()) {
                int count = 0;
                while (rs.next()) {
                    count++;
                    Map<String, Object> job = new HashMap<>();
                    
                    job.put("bookmarkId", rs.getInt("bookmark_id"));
                    job.put("jobId", rs.getInt("job_id"));
                    job.put("candidateId", rs.getInt("candidate_id"));
                    job.put("title", rs.getString("title"));
                    job.put("companyName", rs.getString("company_name"));
                    job.put("location", rs.getString("location"));
                    job.put("jobType", rs.getString("job_type"));
                    job.put("experienceLevel", rs.getString("experience_level"));
                    job.put("salary", rs.getString("salary"));
                    job.put("shortDescription", rs.getString("short_description"));
                    job.put("deadline", rs.getTimestamp("deadline"));
                    job.put("companyEmail", rs.getString("company_email"));
                    
                    bookmarkedJobs.add(job);
                    
                    System.out.println(" Found bookmark " + count + ": " + 
                                     rs.getString("title") + " at " + rs.getString("company_name"));
                }
                
                System.out.println(" Total bookmarked jobs found: " + count);
            }
        } catch (SQLException e) {
            System.err.println(" Error getting bookmarked jobs: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
        
        return bookmarkedJobs;
    }
    
    /**
     * Get count of bookmarked jobs for a candidate
     */
    public int getBookmarkedJobsCount(int candidateId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM [dbo].[bookmark] WHERE candidate_id = ?";
        
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, candidateId);
            
            try (ResultSet rs = st.executeQuery()) {
                int count = rs.next() ? rs.getInt(1) : 0;
                System.out.println(" Bookmark count for candidate " + candidateId + ": " + count);
                return count;
            }
        } catch (SQLException e) {
            System.err.println(" Error counting bookmarks: " + e.getMessage());
            throw e;
        }
    }
    
    /**
     * Get all bookmarked job IDs for a candidate
     */
    public List<Integer> getBookmarkedJobIds(int candidateId) throws SQLException {
        String sql = "SELECT job_id FROM [dbo].[bookmark] WHERE candidate_id = ?";
        List<Integer> jobIds = new ArrayList<>();
        
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, candidateId);
            
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    jobIds.add(rs.getInt("job_id"));
                }
            }
        } catch (SQLException e) {
            System.err.println(" Error getting bookmarked job IDs: " + e.getMessage());
            throw e;
        }
        
        return jobIds;
    }
    
    /**
     * Debug method - Test database and show bookmark data
     */
    public void debugBookmarkData(int candidateId) throws SQLException {
        System.out.println("=== BOOKMARK DEBUG FOR CANDIDATE " + candidateId + " ===");
        
        // Test connection
        if (c == null || c.isClosed()) {
            System.out.println(" Database connection is null or closed!");
            return;
        }
        System.out.println("✅ Database connection is active");
        
        // Count total bookmarks in system
        String sql = "SELECT COUNT(*) FROM [dbo].[bookmark]";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    int totalBookmarks = rs.getInt(1);
                    System.out.println(" Total bookmarks in system: " + totalBookmarks);
                }
            }
        }
        
        // Count bookmarks for this candidate
        sql = "SELECT COUNT(*) FROM [dbo].[bookmark] WHERE candidate_id = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, candidateId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    int candidateBookmarks = rs.getInt(1);
                    System.out.println(" Bookmarks for candidate " + candidateId + ": " + candidateBookmarks);
                }
            }
        }
        
        // Show sample bookmark data
        sql = "SELECT TOP 5 b.bookmark_id, b.candidate_id, b.job_id, jp.title, r.company_name " +
              "FROM [dbo].[bookmark] b " +
              "LEFT JOIN [dbo].[job_post] jp ON b.job_id = jp.job_id " +
              "LEFT JOIN [dbo].[recruiter] r ON jp.recruiter_id = r.recruiter_id " +
              "WHERE b.candidate_id = ?";
        
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, candidateId);
            try (ResultSet rs = st.executeQuery()) {
                System.out.println(" Sample bookmarks for candidate " + candidateId + ":");
                while (rs.next()) {
                    System.out.println("   - Bookmark ID: " + rs.getInt("bookmark_id") + 
                                     ", Job ID: " + rs.getInt("job_id") + 
                                     ", Title: " + rs.getString("title") + 
                                     ", Company: " + rs.getString("company_name"));
                }
            }
        }
        
        // Check if job_post and recruiter tables have data
        sql = "SELECT COUNT(*) FROM [dbo].[job_post]";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    System.out.println("Total jobs in system: " + rs.getInt(1));
                }
            }
        }
        
        sql = "SELECT COUNT(*) FROM [dbo].[recruiter]";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    System.out.println("Total recruiters in system: " + rs.getInt(1));
                }
            }
        }
    }
    
    /**
     * Create test bookmark for debugging
     */
    public boolean createTestBookmark(int candidateId) throws SQLException {
        System.out.println(" Creating test bookmark for candidate: " + candidateId);
        
        // Get first available job
        String sql = "SELECT TOP 1 job_id FROM [dbo].[job_post]";
        int testJobId = -1;
        
        try (PreparedStatement st = c.prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    testJobId = rs.getInt("job_id");
                    System.out.println(" Found test job ID: " + testJobId);
                } else {
                    System.out.println(" No jobs found in job_post table!");
                    return false;
                }
            }
        }
        
        // Create bookmark
        return addBookmark(candidateId, testJobId);
    }
}