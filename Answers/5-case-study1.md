When deciding whether to replace your existing SQL Server design with SQL Server Graph Tables or to use a hybrid approach (graph alongside traditional relational tables), you need to consider several factors, including the complexity of your data, the types of queries you need to perform, and the potential impact on your application's performance and maintainability.

### Key Considerations:

1. **Nature of Your Data and Queries**:
   - If your application heavily relies on traversing complex relationships between entities (e.g., finding the shortest path between company sections, calculating costs and delays across routes), a graph database or SQL Server Graph Tables could be more efficient.
   - If your queries are primarily simple joins or aggregations, the traditional relational model might still be sufficient.

2. **Performance**:
   - Graph databases excel at traversing relationships quickly, especially for recursive or path-based queries. If your current system struggles with performance for such queries, a graph-based solution could improve this.
   - However, if your queries are already optimized and perform well in the relational model, introducing a graph database might not provide significant benefits.

3. **Data Complexity**:
   - If your data model involves many-to-many relationships, hierarchical structures, or interconnected entities, a graph model can simplify the design and make it more intuitive.
   - If your data is mostly tabular and relationships are straightforward, the relational model might be easier to manage.

4. **Hybrid Approach**:
   - You can use SQL Server Graph Tables alongside traditional relational tables. This allows you to leverage the strengths of both models:
     - Use relational tables for structured, tabular data.
     - Use graph tables for complex relationships and path-based queries.
   - This approach minimizes disruption to your existing system while enabling you to handle graph-like queries more efficiently.

5. **Migration Effort**:
   - Migrating entirely to a graph model can be time-consuming and risky, especially if your application is large and complex.
   - A hybrid approach allows you to incrementally introduce graph capabilities without a full rewrite.

6. **Tooling and Expertise**:
   - Evaluate whether your team has the expertise to work with graph databases or SQL Server Graph Tables.
   - Consider the availability of tools and libraries for your chosen approach.

7. **Future Scalability**:
   - If you anticipate that your data relationships will become even more complex in the future, investing in a graph-based solution now might be a good long-term strategy.

### Recommendations:

- **Start with a Hybrid Approach**:
  - Introduce SQL Server Graph Tables for the specific parts of your system that involve complex relationships and path-based queries.
  - Keep the traditional relational tables for simpler data and queries.
  - This allows you to test the benefits of graph technology without fully committing to it.

- **Evaluate Performance**:
  - Benchmark your critical queries using both the traditional relational model and the graph model to see which performs better for your use case.

- **Plan for Incremental Migration**:
  - If the hybrid approach proves beneficial, you can gradually migrate more parts of your system to the graph model over time.

- **Consider SQL Server Graph Tables**:
  - Since you're already using SQL Server, leveraging its built-in graph capabilities (introduced in SQL Server 2017) might be easier than adopting a separate graph database. This avoids the need for additional infrastructure and simplifies integration.

- **Monitor and Optimize**:
  - Continuously monitor the performance and maintainability of your system as you introduce graph elements. Optimize based on real-world usage patterns.

### Conclusion:
A hybrid approach is often the most practical solution when transitioning from a traditional relational model to a graph model. It allows you to leverage the strengths of both systems while minimizing risk and disruption. SQL Server Graph Tables can be a good middle ground, enabling you to handle complex relationships without abandoning your existing relational design.