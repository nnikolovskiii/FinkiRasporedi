﻿// <auto-generated />
using System;
using FinkiRasporedi.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace FinkiRasporedi.Migrations
{
    [DbContext(typeof(ApplicationDbContext))]
    [Migration("20240831083247_AbbreviationLectureSlot")]
    partial class AbbreviationLectureSlot
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.7")
                .HasAnnotation("Proxies:ChangeTracking", false)
                .HasAnnotation("Proxies:CheckEquality", false)
                .HasAnnotation("Proxies:LazyLoading", true)
                .HasAnnotation("Relational:MaxIdentifierLength", 64);

            MySqlModelBuilderExtensions.AutoIncrementColumns(modelBuilder);

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.Course", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("varchar(255)");

                    b.Property<string>("SemesterCode")
                        .IsRequired()
                        .HasColumnType("varchar(255)");

                    b.Property<string>("SubjectId")
                        .HasColumnType("varchar(255)");

                    b.HasKey("Id");

                    b.HasIndex("SemesterCode");

                    b.HasIndex("SubjectId");

                    b.ToTable("courses");
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.CourseProfessor", b =>
                {
                    b.Property<string>("CourseId")
                        .HasColumnType("varchar(255)");

                    b.Property<string>("ProfessorId")
                        .HasColumnType("varchar(255)");

                    b.HasKey("CourseId", "ProfessorId");

                    b.HasIndex("ProfessorId");

                    b.ToTable("courseprofessors");
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.Lecture", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    MySqlPropertyBuilderExtensions.UseMySqlIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("CourseId")
                        .IsRequired()
                        .HasColumnType("varchar(255)");

                    b.Property<int>("Day")
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .HasColumnType("longtext");

                    b.Property<string>("ProfessorId")
                        .IsRequired()
                        .HasColumnType("varchar(255)");

                    b.Property<string>("RoomName")
                        .IsRequired()
                        .HasColumnType("varchar(255)");

                    b.Property<int>("TimeFrom")
                        .HasColumnType("int");

                    b.Property<int>("TimeTo")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("CourseId");

                    b.HasIndex("ProfessorId");

                    b.HasIndex("RoomName");

                    b.ToTable("lectures", (string)null);
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.LectureSlot", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    MySqlPropertyBuilderExtensions.UseMySqlIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Abbreviation")
                        .HasColumnType("longtext");

                    b.Property<int?>("Day")
                        .HasColumnType("int");

                    b.Property<string>("HexColor")
                        .HasColumnType("longtext");

                    b.Property<int?>("LectureId")
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .HasColumnType("longtext");

                    b.Property<int?>("TimeFrom")
                        .HasColumnType("int");

                    b.Property<int?>("TimeTo")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("LectureId");

                    b.ToTable("lectureslots", (string)null);
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.Professor", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("varchar(255)");

                    b.Property<string>("Email")
                        .HasColumnType("longtext");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("longtext");

                    b.Property<int?>("ProfessorTitle")
                        .HasColumnType("int");

                    b.Property<int?>("ScheduleId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("ScheduleId")
                        .IsUnique();

                    b.ToTable("professors");
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.Room", b =>
                {
                    b.Property<string>("Name")
                        .HasColumnType("varchar(255)");

                    b.Property<string>("Abbreviation")
                        .HasColumnType("longtext");

                    b.Property<int?>("ScheduleId")
                        .HasColumnType("int");

                    b.HasKey("Name");

                    b.HasIndex("ScheduleId")
                        .IsUnique();

                    b.ToTable("rooms");
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.Schedule", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    MySqlPropertyBuilderExtensions.UseMySqlIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("longtext");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("longtext");

                    b.Property<string>("StudentId")
                        .HasColumnType("varchar(255)");

                    b.HasKey("Id");

                    b.HasIndex("StudentId");

                    b.ToTable("schedules");
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.Semester", b =>
                {
                    b.Property<string>("Code")
                        .HasColumnType("varchar(255)");

                    b.Property<int?>("SemesterType")
                        .HasColumnType("int");

                    b.Property<string>("Year")
                        .HasColumnType("longtext");

                    b.HasKey("Code");

                    b.ToTable("semesters");
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.Subject", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("varchar(255)");

                    b.Property<string>("Abbreviation")
                        .HasColumnType("longtext");

                    b.Property<int>("Level")
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("longtext");

                    b.HasKey("Id");

                    b.ToTable("subjects");
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Identity.Student", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("varchar(255)");

                    b.Property<int>("AccessFailedCount")
                        .HasColumnType("int");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken()
                        .HasColumnType("longtext");

                    b.Property<string>("Email")
                        .HasMaxLength(256)
                        .HasColumnType("varchar(256)");

                    b.Property<bool>("EmailConfirmed")
                        .HasColumnType("tinyint(1)");

                    b.Property<bool>("LockoutEnabled")
                        .HasColumnType("tinyint(1)");

                    b.Property<DateTimeOffset?>("LockoutEnd")
                        .HasColumnType("datetime(6)");

                    b.Property<string>("NormalizedEmail")
                        .HasMaxLength(256)
                        .HasColumnType("varchar(256)");

                    b.Property<string>("NormalizedUserName")
                        .HasMaxLength(256)
                        .HasColumnType("varchar(256)");

                    b.Property<string>("PasswordHash")
                        .HasColumnType("longtext");

                    b.Property<string>("PhoneNumber")
                        .HasColumnType("longtext");

                    b.Property<bool>("PhoneNumberConfirmed")
                        .HasColumnType("tinyint(1)");

                    b.Property<string>("SecurityStamp")
                        .HasColumnType("longtext");

                    b.Property<bool>("TwoFactorEnabled")
                        .HasColumnType("tinyint(1)");

                    b.Property<string>("UserName")
                        .HasMaxLength(256)
                        .HasColumnType("varchar(256)");

                    b.HasKey("Id");

                    b.HasIndex("NormalizedEmail")
                        .HasDatabaseName("EmailIndex");

                    b.HasIndex("NormalizedUserName")
                        .IsUnique()
                        .HasDatabaseName("UserNameIndex");

                    b.ToTable("AspNetUsers", (string)null);
                });

            modelBuilder.Entity("LectureSlotSchedule", b =>
                {
                    b.Property<int>("LecturesId")
                        .HasColumnType("int");

                    b.Property<int>("ScheduleId")
                        .HasColumnType("int");

                    b.HasKey("LecturesId", "ScheduleId");

                    b.HasIndex("ScheduleId");

                    b.ToTable("schedulelectures", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRole", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("varchar(255)");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken()
                        .HasColumnType("longtext");

                    b.Property<string>("Name")
                        .HasMaxLength(256)
                        .HasColumnType("varchar(256)");

                    b.Property<string>("NormalizedName")
                        .HasMaxLength(256)
                        .HasColumnType("varchar(256)");

                    b.HasKey("Id");

                    b.HasIndex("NormalizedName")
                        .IsUnique()
                        .HasDatabaseName("RoleNameIndex");

                    b.ToTable("AspNetRoles", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    MySqlPropertyBuilderExtensions.UseMySqlIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("ClaimType")
                        .HasColumnType("longtext");

                    b.Property<string>("ClaimValue")
                        .HasColumnType("longtext");

                    b.Property<string>("RoleId")
                        .IsRequired()
                        .HasColumnType("varchar(255)");

                    b.HasKey("Id");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetRoleClaims", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    MySqlPropertyBuilderExtensions.UseMySqlIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("ClaimType")
                        .HasColumnType("longtext");

                    b.Property<string>("ClaimValue")
                        .HasColumnType("longtext");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("varchar(255)");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserClaims", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.Property<string>("LoginProvider")
                        .HasMaxLength(128)
                        .HasColumnType("varchar(128)");

                    b.Property<string>("ProviderKey")
                        .HasMaxLength(128)
                        .HasColumnType("varchar(128)");

                    b.Property<string>("ProviderDisplayName")
                        .HasColumnType("longtext");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("varchar(255)");

                    b.HasKey("LoginProvider", "ProviderKey");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserLogins", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.Property<string>("UserId")
                        .HasColumnType("varchar(255)");

                    b.Property<string>("RoleId")
                        .HasColumnType("varchar(255)");

                    b.HasKey("UserId", "RoleId");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetUserRoles", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.Property<string>("UserId")
                        .HasColumnType("varchar(255)");

                    b.Property<string>("LoginProvider")
                        .HasMaxLength(128)
                        .HasColumnType("varchar(128)");

                    b.Property<string>("Name")
                        .HasMaxLength(128)
                        .HasColumnType("varchar(128)");

                    b.Property<string>("Value")
                        .HasColumnType("longtext");

                    b.HasKey("UserId", "LoginProvider", "Name");

                    b.ToTable("AspNetUserTokens", (string)null);
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.Course", b =>
                {
                    b.HasOne("FinkiRasporedi.Models.Domain.Semester", "Semester")
                        .WithMany()
                        .HasForeignKey("SemesterCode")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("FinkiRasporedi.Models.Domain.Subject", "Subject")
                        .WithMany()
                        .HasForeignKey("SubjectId");

                    b.Navigation("Semester");

                    b.Navigation("Subject");
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.CourseProfessor", b =>
                {
                    b.HasOne("FinkiRasporedi.Models.Domain.Course", "Course")
                        .WithMany()
                        .HasForeignKey("CourseId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("FinkiRasporedi.Models.Domain.Professor", "Professor")
                        .WithMany()
                        .HasForeignKey("ProfessorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Course");

                    b.Navigation("Professor");
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.Lecture", b =>
                {
                    b.HasOne("FinkiRasporedi.Models.Domain.Course", "Course")
                        .WithMany()
                        .HasForeignKey("CourseId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("FinkiRasporedi.Models.Domain.Professor", "Professor")
                        .WithMany("Lectures")
                        .HasForeignKey("ProfessorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("FinkiRasporedi.Models.Domain.Room", "Room")
                        .WithMany("Lectures")
                        .HasForeignKey("RoomName")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Course");

                    b.Navigation("Professor");

                    b.Navigation("Room");
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.LectureSlot", b =>
                {
                    b.HasOne("FinkiRasporedi.Models.Domain.Lecture", "Lecture")
                        .WithMany()
                        .HasForeignKey("LectureId");

                    b.Navigation("Lecture");
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.Professor", b =>
                {
                    b.HasOne("FinkiRasporedi.Models.Domain.Schedule", "Schedule")
                        .WithOne()
                        .HasForeignKey("FinkiRasporedi.Models.Domain.Professor", "ScheduleId");

                    b.Navigation("Schedule");
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.Room", b =>
                {
                    b.HasOne("FinkiRasporedi.Models.Domain.Schedule", "Schedule")
                        .WithOne()
                        .HasForeignKey("FinkiRasporedi.Models.Domain.Room", "ScheduleId");

                    b.Navigation("Schedule");
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.Schedule", b =>
                {
                    b.HasOne("FinkiRasporedi.Models.Identity.Student", null)
                        .WithMany("Schedules")
                        .HasForeignKey("StudentId");
                });

            modelBuilder.Entity("LectureSlotSchedule", b =>
                {
                    b.HasOne("FinkiRasporedi.Models.Domain.LectureSlot", null)
                        .WithMany()
                        .HasForeignKey("LecturesId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("FinkiRasporedi.Models.Domain.Schedule", null)
                        .WithMany()
                        .HasForeignKey("ScheduleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole", null)
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.HasOne("FinkiRasporedi.Models.Identity.Student", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.HasOne("FinkiRasporedi.Models.Identity.Student", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole", null)
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("FinkiRasporedi.Models.Identity.Student", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.HasOne("FinkiRasporedi.Models.Identity.Student", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.Professor", b =>
                {
                    b.Navigation("Lectures");
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Domain.Room", b =>
                {
                    b.Navigation("Lectures");
                });

            modelBuilder.Entity("FinkiRasporedi.Models.Identity.Student", b =>
                {
                    b.Navigation("Schedules");
                });
#pragma warning restore 612, 618
        }
    }
}
