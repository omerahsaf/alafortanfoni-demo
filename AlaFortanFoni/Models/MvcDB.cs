namespace AlaFortanFoni.Models
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class MvcDB : DbContext  // Database baðlantýsýnýn oluþturulduðu kýsým.
    {
        public MvcDB()
            : base("name=MvcDB")
        {
        }

        public virtual DbSet<Article> Article { get; set; }
        public virtual DbSet<Category> Category { get; set; }
        public virtual DbSet<Comment> Comment { get; set; }
        public virtual DbSet<Role> Role { get; set; }
        public virtual DbSet<User> User { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Article>()
                .Property(e => e.Time)
                .IsFixedLength();
        }
    }
}
