namespace AlaFortanFoni.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("User")]
    public partial class User
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public User()
        {
            Article = new HashSet<Article>();
            Comment = new HashSet<Comment>();
        }

        public int UserId { get; set; }

        [StringLength(40)]
        public string UserName { get; set; }

        [StringLength(50)]
        public string Mail { get; set; }

        [StringLength(50)]
        public string Password { get; set; }

        [StringLength(500)]
        public string UserPhoto { get; set; }

        public int? RoleId { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Article> Article { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Comment> Comment { get; set; }

        public virtual Role Role { get; set; }
    }
}
