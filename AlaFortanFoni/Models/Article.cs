namespace AlaFortanFoni.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
    using System.Web.Mvc;

    [Table("Article")]
    public partial class Article
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Article()
        {
            Comment = new HashSet<Comment>();
        }

        public int ArticleId { get; set; }

        [StringLength(250)]
        public string Title { get; set; }

        [UIHint("tinymce_full_compressed"),AllowHtml] // Makalale eklemek için kullanýþlý olan Tinymce yi nugget menaggerden indirip bu kýsýmda gerekli olduðu içim ekledim.
        public string Text { get; set; }

        [StringLength(500)]
        public string ArticlePhoto { get; set; }

        [StringLength(10)]
        public string Time { get; set; }

        public int? CategoryId { get; set; }

        public int? UserId { get; set; }

        public int? Displayed { get; set; }

        public virtual Category Category { get; set; }

        public virtual User User { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Comment> Comment { get; set; }
    }
}
