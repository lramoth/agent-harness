# Architecture

This document describes the application's current structure. It reflects
what exists now, not how it got here or why — that history lives in each
feature's Work File. Update this document whenever a feature changes the
structure it describes; do not append historical notes here.

## Overview

A concise description of what the application is and how its major parts
fit together.

## Components

- Component name — responsibility, and where it lives in the codebase.

## Data Flow

Describe how data moves through the system: entry points, transformations,
storage, and exit points.

## External Dependencies

- Services, APIs, or infrastructure the application depends on.

## Key Decisions

Standing constraints or choices that shape the current structure (e.g.
"single-process, no queue" or "all state in Postgres"). Remove entries here
if a later feature supersedes them — this section describes what is true
now, not a decision log.
